//
//  Injector+Injection.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation

@propertyWrapper
struct Inject<Component> {
    let wrappedValue: Component
    init() {
        self.wrappedValue = Injector.shared.resolve(Component.self)
    }
}
