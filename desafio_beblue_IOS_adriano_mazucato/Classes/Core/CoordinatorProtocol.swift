//
//  CoordinatorProtocol.swift
//  Melhor Lugar Organizador
//
//  Created by Adriano Mazucato on 18/08/18.
//  Copyright © 2018 Adriano Mazucato. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class {

    var parent: CoordinatorProtocol? { get set }
    var identifier: String { get }
    var childCoordinators: [String: CoordinatorProtocol] { get }
    
    func start(completion: (() -> Void)?)
    func stop(completion: (() -> Void)?)
    func startChild(coordinator: CoordinatorProtocol, completion: (() -> Void)?)
    func stopChild(coordinator: CoordinatorProtocol, completion: (() -> Void)?)
}


class Coordinator:  CoordinatorProtocol {
    public var parent: CoordinatorProtocol?
    public var childCoordinators: [String : CoordinatorProtocol] = [:]
    var identifier: String = ""
    
    weak var rootViewController: UIViewController?
    
    public init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    func start(completion: (() -> Void)? = nil) { }
    func stop(completion: (() -> Void)? = nil) { }
    
    public func startChild(coordinator: CoordinatorProtocol, completion: (() -> Void)? = nil) {
        childCoordinators[coordinator.identifier] = coordinator
        coordinator.parent = self
        coordinator.start(completion: nil)
    }
    
    public func stopChild(coordinator: CoordinatorProtocol, completion: (() -> Void)? = nil) {
        coordinator.parent = nil
        coordinator.stop { [unowned self] in
            self.childCoordinators.removeValue(forKey: coordinator.identifier)
            completion?()
        }
    }
}
