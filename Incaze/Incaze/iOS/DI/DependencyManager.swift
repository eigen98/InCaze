//
//  DependencyManager.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/19.
//

import Foundation
import Swinject

class DependencyManager {
    //애플리케이션의 모든 종속성에 대한 중앙 레지스트리 역할을 하는 싱글톤입니다.
    static let shared = DependencyManager()
    
    private let container = Container()
    
//    private init() {
//        registerViews()
//        registerViewModels()
//        registerServices()
//        registerRepositories()
//    }
    func register(){
        registerViews()
        registerViewModels()
        registerServices()
        registerRepositories()
    }
    // View
    func registerViews() {
        //CrewListView 종속성은 register 사용하여 등록
        container.register(CrewListView.self) { resolver in
            let viewModel = resolver.resolve(CrewListViewModel.self)
            return CrewListView(viewModel: viewModel!) }
    }
    
    // ViewModel
    func registerViewModels() {
        container.register(CrewListViewModel.self) { resolver in
            let service = resolver.resolve(CrewService.self)!
            return CrewListViewModel(service: service)
        }
    }
    
    // Model
    func registerServices() {
        container.register(CrewService.self) { resolver in
            let repository = resolver.resolve(CrewRepository.self)!
            return CrewServiceServiceImpl(crewRepo: repository)
        }
    }
    
    func registerRepositories() {
        container.register(CrewRepository.self) { _ in CrewRepositoryImpl() }
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
}
