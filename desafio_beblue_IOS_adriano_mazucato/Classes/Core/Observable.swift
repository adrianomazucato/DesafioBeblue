//
//  Observable.swift
//  MelhorLugar
//
//  Created by Adriano Mazucato on 07/05/17.
//  Copyright © 2017 Adriano MAzucato. All rights reserved.
//

import Foundation

class Observable<ValueType> {
    typealias React = (ValueType) -> Void
    var reactionHandlers :[String:React] = [:]
    
    var sender: ((ValueType) -> Void)? {
        didSet {
            if let sender = self.sender {
                sender(value)
            }
        }
    }
    
    var value: ValueType {
        didSet {
            if let sender = self.sender {
                sender(value)
            }
        }
    }
    
    init(_ value: ValueType) {
        self.value = value
    }
    
    func bind(_ sender:@escaping ((ValueType) -> Void)) {
        self.sender = sender
    }
    
    func unbind() {
        self.sender = nil
    }
    
    func iterateThroughHandlers() {
        _ = reactionHandlers.map { _, handler in
            handler(self.value)
        }
    }
    
    deinit {
        self.sender = nil
    }
}

//protocol Arrayable {
//    associatedtype Element
//    mutating func append(_ element :Element)
//    //mutating func insert(_ element :Element, atIndex :Int)
//    mutating func removeAtIndex(_ index :Int) -> Element
//    mutating func appendContentsOf(_ array :Array<Element>)
//}
