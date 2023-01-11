//
//  Container.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation
import Swinject

func buildContainer() -> Container {
    let container = Container()
    container.registerService()
    container.registerViewModel()
    container.registerRepository()
    return container
}

private extension Container {
    
    func registerService() {
        register(URLSession.self) {_ in
            URLSession(configuration: .default)
        }
        .inObjectScope(.container)
        
        register(StoreService.self) { r in
            StoreService(session: r.resolve(URLSession.self)!)
        }
        .inObjectScope(.container)
    }
    
    func registerViewModel() {
//        container.register(FishViewModel.self) { resolver in
//            FishViewModel()
//        }
    }
    
    
    func registerRepository() {
        self.register(StoreRepository.self) { resolver in
            StoreRepositoryImpl(service: resolver.resolve(StoreService.self)!)
        }
    }
    
}
