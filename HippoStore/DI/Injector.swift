//
//  Container.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation
import Swinject

class Injector {
    
    static let shared = Injector.init()
    
    private init() { }
    
    private var container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
    
    func setDependencyContainer(_ container: Container) {
        self.container = container
    }
    
}
