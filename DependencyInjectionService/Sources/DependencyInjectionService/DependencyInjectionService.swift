//
//  File.swift
//  
//
//  Created by Jithin M on 22/05/22.
//

import Foundation
import NetworkService

public protocol DIContainerProtocol {
    func registerDependency<Component>(type: Component.Type, component: Any)
    func resolveDependency<Component>(type: Component.Type) -> Component?
    func registerAppDependencies()
}

public final class DIContainer: DIContainerProtocol {

    static let shared = DIContainer()

    private init() {}

    var components: [String: Any] = [:]

    public func resolveDependency<Component>(type: Component.Type) -> Component? {
        return components["\(type)"] as? Component
    }

    public func registerDependency<Component>(type: Component.Type, component: Any) {
        components["\(type)"] = component
    }

    public func registerAppDependencies() {
        registerDependency(type: NetworkService.self, component: NetworkService())
    }

}
