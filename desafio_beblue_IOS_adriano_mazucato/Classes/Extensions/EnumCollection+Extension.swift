//
//  EnumCollection+Extension.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

protocol EnumCollection : Hashable {}

extension RawRepresentable where Self: Hashable {
    
    private static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var index = 0
        
        let closure: () -> T? = {
            let next = withUnsafePointer(to: &index) {
                $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
            }
            guard next.hashValue == index else { return nil }
            index += 1
            return next
        }
        
        return AnyIterator(closure)
    }
    
    static var allValues: [Self.RawValue] {
        return iterateEnum(self).map { $0.rawValue }
    }
    
    static var allCases: [Self] {
        return iterateEnum(self).map { $0 }
    }
}
