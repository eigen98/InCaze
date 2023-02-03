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
    
    
    let birthDateType = HKCharacteristicType.characteristicType(forIdentifier: .dateOfBirth)!
    let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
    let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
    
    /*
     권한 요청
     */
//    func requestAuthorization(){
//        self.healthStore.requestAuthorization (toShare: nil , read: read) { (success, error) in
//            if error != nil {
//                print (error.debugDescription)
//            }else{
//                if success {
//                    print ("권한이 허락되었습니다. ")
//                }else{
//
//                    print("권한이 아직 없어요. ")
//                }
//            }
//        }
//
//    }
    
    func requestAuthorization() {
        let healthKitTypesToRead = Set([
            birthDateType,
            heightType,
            weightType
        ])

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (success, error) in
            if !success {
                print("Error requesting authorization: \(error?.localizedDescription ?? "Unknown error")")
               
            }
        }
    }
    
    
    func readMostRecentAgeSample() {
        let now = Date()
        let birthday = try? healthStore.dateOfBirthComponents()

        guard let birthYear = birthday?.year, let birthMonth = birthday?.month, let birthDay = birthday?.day else {
            print("Error reading birthday from HealthKit")
            return
        }

        let birthDate = Calendar.current.date(from: DateComponents(year: birthYear, month: birthMonth, day: birthDay))
        let ageComponents = Calendar.current.dateComponents([.year], from: birthDate!, to: now)

        guard let age = ageComponents.year else {
            print("Error calculating age")
            return
        }

        print("Most recent age: \(age)")
        UserManager.shared.age = age
    }

    func readMostRecentHeightSample() {
        let heightSampleQuery = HKSampleQuery(sampleType: heightType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, samples, error) in
            if let heightSample = samples?.first as? HKQuantitySample {
                let height = heightSample.quantity.doubleValue(for: HKUnit.meter())
                print("Most recent height: \(height) m")
                UserManager.shared.height = height
            } else {
                print("Error reading height from HealthKit")
            }
        }
        

        healthStore.execute(heightSampleQuery)
    }

    func readMostRecentWeightSample() {
        let weightSampleQuery = HKSampleQuery(sampleType: weightType, predicate: nil, limit: 1, sortDescriptors: nil) { (query, samples, error) in
            if let weightSample = samples?.first as? HKQuantitySample {
                let weight = weightSample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                print("Most recent weight: \(weight) kg")
                UserManager.shared.height = weight
            } else {
                print("Error reading weight from HealthKit")
            }
        }

        healthStore.execute(weightSampleQuery)
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
     Harris-Benedict equation in Swift
     calculate the number of calories burned during a running session
     */
    func caloriesBurned(weight: Double, height: Double, age: Int, met : Double, duration: Double) -> Int {
        let bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * Double(age))
        // met = MET value for running
        let caloriesBurned = bmr * met * (duration / 60.0)
        return Int(caloriesBurned)
    }

   
}
