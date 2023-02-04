//
//  ChallengeStartViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/04.
//

import Foundation
import Combine

class ChallengeStartViewModel:ObservableObject{
    
    private var bag = Set<AnyCancellable>()
    
    //service
    var locationService = LocationService()
    var runService = RunService()
    var challengeService = ChallengeServiceImpl(userInfoRepo: UserInfoRepositoryImpl(),
                                                crewRepo: CrewRepositoryImpl())
    
    
    typealias ValueUnitPair = (value: String, units: String)
    
    var startDate: Date = Date()
    @Published var distance: Double = 0.0
    @Published var duration: Double = 0.0
    @Published var pace: Double = 0.0
    @Published var caloriesBurned: Int = 0
    @Published var heartRate: Int = 0
    
    //연결 해두고 원하는 시점에 이벤트를 보냄
    var distanceSubject =  PassthroughSubject<Double, Never>()
    var progressEndSubject = CurrentValueSubject<Bool,Never>(false)
    
    func startRace(){
        locationService.ready()
        locationService.start()
        
        runService.start()
        
        observerDistance()
    }
    /*
     종료
     */
    func endRace(stage: String, isSuccess: Bool){
        saveResult(stage: stage, isSuccess: isSuccess)
    }
    /*
     결과 서버 반영
     */
    func saveResult(stage : String, isSuccess : Bool){
        challengeService.postChallengeResult(result: RunningSession(stage: stage,
                                                                    isCompleted: isSuccess,
                                                                    date: startDate,
                                                                    distance: distance,
                                                                    duration: duration,
                                                                    pace: pace,
                                                                    caloriesBurned: caloriesBurned))
        .sink(receiveCompletion: {_ in
            
        }, receiveValue: {_ in
            print("챌린지 결과 업로드 완료")
        })
        .store(in: &bag)
    }
    
    /*
     거리 측정 시작
     */
    func observerDistance(){
        //Distance
        
        
        startDate = Date() //시작 시간 초기화
        
        runService.distance
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { self.distanceFormat($0, unit: Settings.shared.distanceUnit) }
        //.assign(to: \.value, on: self)
            .sink{[weak self]
                value in
                print("now distance : \(value)")
                var result = value
                
                result.removeLast(3)
                let distanceDouble =  Double("\(result.removeLast(2))") ?? 0.0
                self?.distance = distanceDouble
                self?.duration = self?.getDuration() ?? 0.0
                self?.pace = self?.getPace(distance: distanceDouble) ?? 0.0
                
                self?.caloriesBurned = self?.getCaloriesBurned(distance: distanceDouble, duration: self?.getDuration() ?? 0.0) ?? 0
                self?.distanceSubject.send(distanceDouble)
            }
            .store(in: &bag)
        
        
    }
    
    func getPace(distance : Double) -> Double {
        let pace =  getDuration()/distance
        if distance == 0.0 {
            return 0.0
        }
        return pace
    }
    
    func getDuration() -> TimeInterval{
        let startTime = startDate
        let endTime = Date()
        let duration = endTime.timeIntervalSince(startTime)
        return duration
    }
    
    func getCaloriesBurned(distance : Double, duration: Double) -> Int{
        let weight = UserManager.shared.weight
        let height = UserManager.shared.height
        let age = UserManager.shared.age
        
        return HealthDataRepository.shared.caloriesBurned(weight: weight,
                                                          height: height,
                                                          age: age,
                                                          met: distance * 1000,
                                                          duration: duration)
    }
    
    func distanceFormat(_ value: Double?, unit: UnitLength) -> String {
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
