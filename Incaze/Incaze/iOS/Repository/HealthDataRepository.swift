//
//  HealthDataRepository.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/25.
//

import Foundation
import HealthKit
class HealthDataRepository{
    static let shared = HealthDataRepository()
    
    init(){
        healthStore = HKHealthStore()
        
        read = Set([HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
                        HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
                        HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])
        
        share = Set([HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
                         HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
                         HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])

    }
    var healthStore = HKHealthStore()
        
    var read = Set([HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
                    HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
                    HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])
    
    var share = Set([HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
                     HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
                     HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!])

    
    /*
     권한 요청
     */
    func requestAuthorization(){
        self.healthStore.requestAuthorization (toShare: nil , read: read) { (success, error) in
            if error != nil {
                print (error.debugDescription)
            }else{
                if success {
                    print ("권한이 허락되었습니다. ")
                }else{
                   
                    print("권한이 아직 없어요. ")
                }
            }
        }
        
    }
    /*
     칼로리 소모 데이터 get
     */
    func getActivityEnergyBurned(completion: @escaping (Double) -> Void){
        guard let activeEnergyBurnedType = HKSampleType.quantityType(forIdentifier:.activeEnergyBurned)else{
            return
        }
        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery (quantityType: activeEnergyBurnedType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var cal: Double = 0
            guard let result = result, let sum = result.sumQuantity() else{
                print("fail")
                return
            }
            cal = sum.doubleValue(for: HKUnit.kilocalorie())
            DispatchQueue.main.async{
                completion (cal)
            }
        }
        healthStore.execute(query)
    }
    
    /*
    건강 관련 mock 데이터 생성.
     시뮬레이터에서 유효한 데이터를 볼 수 없기때문
     */
    func getTestData() -> [Double]{
        let first = Double(Int.random(in: 20...99))
        let second = Double(Int.random(in: 20...99))
        let third = Double(Int.random(in: 20...99))
        
        return [first, second, third]
    }
}
