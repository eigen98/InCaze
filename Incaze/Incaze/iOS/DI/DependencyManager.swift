//
//  DependencyManager.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/19.
//

import Foundation
import Swinject

class DependencyManager {
    let container = Container()
    static let shared = DependencyManager()
    
    private init(){
        
    }
    
    public func registerDependencies(){
        //container.register(<#T##serviceType: Service.Type##Service.Type#>, factory: <#T##(Resolver) -> Service#>)
    }
}
