//
//  MLRACTextField.swift
//  Melhor Lugar
//
//  Created by Adriano Mazucato on 24/11/17.
//  Copyright © 2017 Adriano Mazucato. All rights reserved.
//

import UIKit

protocol ControlObservable {
    func bind(to object: NSObject, property: String, controllEvent: UIControl.Event)
    func unBind()
}

extension ControlObservable where Self: UIControl {
    
    func bind(to object: NSObject, property: String, controllEvent: UIControl.Event) {
        if closureRAC == nil {
            closureRAC = ClosureRAC(attachTo: self, object: object, property: property)
        }
        
        removeTarget(closureRAC, action: #selector(ClosureRAC.textFieldDidChange(_:)), for: controllEvent)
        self.addTarget(closureRAC, action: #selector(ClosureRAC.textFieldDidChange(_:)), for: controllEvent)
    }
    
    func unBind() {
        removeTarget(nil, action: nil, for: .allEvents)
    }
}

extension UIControl: ControlObservable {
    private struct AssociatedKey {
        static var keyAssociatedObject = "keyAssociatedObject"
    }
    
    var closureRAC: ClosureRAC? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.keyAssociatedObject) as? ClosureRAC
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.keyAssociatedObject, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

class ClosureRAC {
    
    let object: NSObject, property: String
    
    init(attachTo: AnyObject,object: NSObject, property: String) {
        self.object = object
        self.property = property
        //objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func textFieldDidChange(_ control: UIControl) {
        if let textField = control as? UITextField {
            self.object.setValue(textField.text, forKey: self.property)
        } else if let datePicker = control as? UIDatePicker {
            self.object.setValue(datePicker.date, forKey: self.property)
        } else if let control = control as? UISegmentedControl {
            self.object.setValue(control.selectedSegmentIndex, forKey: self.property)
        }
    }
}
