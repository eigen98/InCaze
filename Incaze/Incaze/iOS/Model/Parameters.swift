//
//  Parameters.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/19.
//

import Foundation
struct Parameters {

    enum Defaults {
        static let altitude = Measurement(value: 0, unit: UnitLength.meters)
        static let temperature = Measurement(value: 20, unit: UnitTemperature.celsius)
        static let wind = Measurement(value: 0, unit: UnitSpeed.metersPerSecond)
        static let mass = Measurement(value: 80, unit: UnitMass.kilograms)
    }

    let avgSpeed: Measurement<UnitSpeed>
    let altitude: Measurement<UnitLength>
    let temperature: Measurement<UnitTemperature>
    let wind: Measurement<UnitSpeed>
    let weight: Measurement<UnitMass>
    let segmentDistance: Measurement<UnitLength>?
    let segmentElevation: Measurement<UnitLength>?

    init(avgSpeed: Measurement<UnitSpeed>,
         altitude: Measurement<UnitLength> = Defaults.altitude,
         temperature: Measurement<UnitTemperature> = Defaults.temperature,
         wind: Measurement<UnitSpeed> = Defaults.wind,
         weight: Measurement<UnitMass> = Defaults.mass,
         segmentDistance: Measurement<UnitLength>? = nil,
         segmentElevation: Measurement<UnitLength>? = nil) {
        self.avgSpeed = avgSpeed
        self.altitude = altitude
        self.temperature = temperature
        self.wind = wind
        self.weight = weight
        self.segmentDistance = segmentDistance
        self.segmentElevation = segmentElevation
    }
}
