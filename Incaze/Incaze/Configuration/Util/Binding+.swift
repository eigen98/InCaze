//
//  Binding+.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/19.
//

import Foundation
import SwiftUI
//Cannot convert value of type 'Binding<String>' to expected argument type 'Binding<Double>'

extension String {
     var double: Double {
         get { Double(self) ?? 0.0 }
         set { self = String(newValue) }
     }
 }
