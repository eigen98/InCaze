//
//  Weight.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/19.
//

import Foundation
struct Weight {

    static func loss(energy: Measurement<UnitEnergy>) -> Measurement<UnitMass> {
        // 3,500 kcal ~ 0.45 kg of fat
        // 1 kcal = 0.000128571 kg
        let kcal = energy.converted(to: .kilocalories)
        return Measurement(value: 0.000128571 * kcal.value, unit: UnitMass.kilograms)
    }
}
