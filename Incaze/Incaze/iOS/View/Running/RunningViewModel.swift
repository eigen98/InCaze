//
//  RunningViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/09.
//

import Foundation
import Combine
import CoreLocation
import MapKit
import Firebase
import FirebaseDatabase

class RunningViewModel : ObservableObject{
    typealias ValueUnitPair = (value: String, units: String)
    @Published var value = "" //speed
    @Published var units = ""
    @Published var distance = "0.0"
    var cancellable = Set<AnyCancellable>()
    private let distanceSubject = PassthroughSubject<Double, Never>()
    private var location: AnyCancellable?
    var locationService = LocationService()
    var runService = RunService()
    var oppUser : User
    var repository : RunningRepositoryImpl
    @Published var channelId : String = ""
    
    @Published var oppDistance = "0.0"
    //제한시간 여부
    @Published var timesUp = true
    
    private var cancelables = Set<AnyCancellable>()
    
    
    init(value: String = "", units: String = "", oppUser: User) {
        self.value = value
        self.units = units
        self.oppUser = oppUser

        var myId = UserManager.shared.id
        var oppId = oppUser.id
        var runningChannelId =  myId > oppId ? myId + "_" + oppId :  oppId + "_" + myId
        
        self.channelId = runningChannelId
        
        self.repository = RunningRepositoryImpl()
        // debounce : 이벤트 간에 지정된 시간이 경과된 후에만 요소를 게시합니다.
        locationService.ready()
        locationService.start()
        
        runService.start()
        
        //Speed
        locationService.speed
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .merge(with: locationService.speed) //Rx CombineLatest와 비슷?
            .removeDuplicates()
            .sink{ value in //Rx Subscribe와 비슷
                let formatted = self.speed(value, unit: UnitSpeed.metersPerSecond)
                self.value = formatted.value

                print("speed RunningViewModel \(value)")

            }
            .store(in: &cancellable)
        
        
        
        //location = locationService.location
//            .assign(to: <#T##ReferenceWritableKeyPath<Root, CLLocation>#>, on: <#T##Root#>)
//            .sink {
//                print("location : \($0)")
//
//
//            }
        
        //Distance
       
        runService.distance
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { self.distance($0, unit: Settings.shared.distanceUnit) }
        //.assign(to: \.value, on: self)
            .sink{
                value in
                print("now distance : \(value)")
                var result = value
                print("runService distance : \(self.channelId)")
                result.removeLast(3)
                if self.channelId.count > 0{
                    print("update my data \(result)")
                    self.updateDistance(distance: Double(result) ?? 9.9)
                   // self.repository.updateMyRunningData(channelId: self.channelId, distance: Double(result) ?? 0.0)
                }
                if Double(result) ?? 0.0 > 0.3{
                    //완주
                    self.repository.postCompleteDate()
                }
                
                self.distance = "\(result.removeLast(2))"
            }
            .store(in: &cancelables)
        // listens for updates to the running distance.
        distanceSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: {[weak self] distance in
                self?.repository.updateMyRunningData(channelId: self?.channelId ?? "", distance: distance)
            })
            .store(in: &cancelables)
    }
    
    func updateDistance(distance: Double) {
            distanceSubject.send(distance)
        }
    
    
    //상대 유저 선택 & 게임 채널 생성 (선택 가능 유저)
    func addRunningChannel(myId : String, oppId : String){
        var channelId =  myId > oppId ? myId + "_" + oppId :  oppId + "_" + myId
        print("addRunningChannel : \(myId) ,\(oppId)")
        let myRef = Database.database().reference().child("Running").child(channelId).child(myId)
        let oppRef = Database.database().reference().child("Running").child(channelId).child(oppId)
        self.channelId = channelId
        print("addRunningChannel channelId : \(channelId)")
        let newData = [
            "completeData" : "",
            "distance" : ""
        ] as [String : Any]
        
        Task{
            do{
                try await myRef.setValue(newData)
                try await oppRef.setValue(newData)
                
               
                observeOppUserScore()
            }catch{
                print("addRunningChannel error : \(error)")
            }
            
        }
        
        
    }
    
    
    /*
     상대방 달리기 거리 Subscribe
     */
    func observeOppUserScore(){
        //start observing using sink on a publisher.
        repository.getRunningData(channelId: self.channelId, oppUserId: oppUser.id).sink{[weak self] distance in
            if let distance, let self{
                self.oppDistance = "\(distance)"
                if distance > 0.3{
                    self.timesUp = true
                    print("상대 종료")
                }
            }
            
        }.store(in: &cancelables)
        
    }
    
    func countDown(completion : @escaping () -> ()){
        print("제한시간 10초")
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            print("제한 시간 종료")
            completion()
        })
    }
    
    //TODO: 내 달리기 거리 업데이트
    func updateMyScore(){
        repository.updateMyRunningData(channelId: self.channelId, distance: 0.0)
    }
    
    func completeRun(){
        repository.postCompleteDate()
    }
    
    
    func distance(_ value: Double?, unit: UnitLength) -> String {
        let meters = Measurement(value: value ?? 0, unit: UnitLength.meters)
        let converted = meters.converted(to: unit)
        return Formatters.distanceFormatter.string(from: converted)
    }
    
    func speed(_ value: Double?, unit: UnitSpeed) -> ValueUnitPair {
        let mps = Measurement(value: value ?? 0, unit: UnitSpeed.metersPerSecond)
        let converted = mps.converted(to: unit)
        return  formatted(from: converted)
    }
    
    func formatted<U: Unit>(from measurement: Measurement<U>) -> ValueUnitPair {
        let value = speedValue.string(from: NSNumber(value: measurement.value))
        let zero = speedValue.string(from: NSNumber(value: Double.zero))!
        let units = speedMeasurement.string(from: measurement.unit)
        return (value ?? zero, units)
    }
    
    var speedValue: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }()
    
    var speedMeasurement: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.numberFormatter.minimumFractionDigits = 1
        return formatter
    }()
    
    
    
}
