//
//  Power.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/19.
//

import Foundation
struct Power {

    // swiftlint:disable identifier_name
    static func power(parameters: Parameters) -> Measurement<UnitPower> {

        // Input
        let v = parameters.avgSpeed.converted(to: .metersPerSecond).value
        let h = parameters.altitude.converted(to: .meters).value
        let t = parameters.temperature.converted(to: .kelvin).value
        let m = parameters.weight.converted(to: .kilograms).value
        let w = parameters.wind.converted(to: .metersPerSecond).value
        let H = parameters.segmentElevation?.converted(to: .meters).value ?? 0
        let L = parameters.segmentDistance?.converted(to: .meters).value ?? 1

        // Constants
        let p = 101325.0 // zero pressure
        let M = 0.0289654 // molar mass of dry air
        let R = 8.31447 // ideal gas constant
        let Hn = 10400.0 // height reference
        let g = 9.8 // gravitational acceleration
        let loss = 0.02 // 2%
        let CdA = [0.388, 0.445, 0.420, 0.300, 0.233, 0.200] // Cd * A
        let Crr = [0.005, 0.004, 0.012] // rolling resistance

        // Calculations
        let rho = p * M / (R * t) * exp(-h / Hn)
        let V = pow(v + w, 2)
        let theta = asin(H / L)

        let Fg = m * g * sin(theta)
        let Fr = m * g * Crr[0] * cos(theta)
        let Fd = 0.5 * CdA[0] * rho * V

        let power = (Fg + Fr + Fd) * v * (1 + loss)

        return Measurement(value: power, unit: .watts)
    }
    // swiftlint:enable identifier_name
}
