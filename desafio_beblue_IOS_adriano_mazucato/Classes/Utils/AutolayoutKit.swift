//
//  AutolayoutKit.swift
//  Melhor Lugar Organizador
//
//  Created by Adriano Mazucato on 12/09/18.
//  Copyright © 2018 Adriano Mazucato. All rights reserved.
//

import UIKit

public typealias AutolayoutView = UIView

public extension AutolayoutView {
    public var mrk: MarkerConstraintView {
        return MarkerConstraintView(view: self)
    }
}

public struct MarkerConstraintView {
    
    internal let view: AutolayoutView
    
    internal init(view: AutolayoutView) {
        self.view = view
    }
    
    //MARK: filling
    @discardableResult
    public func fillSuperview(_ edges: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        if let superview = self.view.superview {
            let topConstraint = top(to: superview, constant: edges.top)
            let leadingConstraint = leading(to: superview, constant: edges.left)
            let bottomConstraint = bottom(to: superview, constant: -edges.bottom)
            let trailingConstraint = trailing(to: superview, constant: -edges.right)
            
            constraints = [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
        }
        
        return constraints
    }
    
    //MARK: sides
    @discardableResult
    public func leading(to view: Any?, attribute: NSLayoutConstraint.Attribute = .leading, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .leading, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func trailing(to view: Any?, attribute: NSLayoutConstraint.Attribute = .trailing, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .trailing, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func left(to view: Any?, attribute: NSLayoutConstraint.Attribute = .left, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .left, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func right(to view: Any?, attribute: NSLayoutConstraint.Attribute = .right, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .right, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func top(to view: Any?, attribute: NSLayoutConstraint.Attribute = .top, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .top, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func bottom(to view: Any?, attribute: NSLayoutConstraint.Attribute = .bottom, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .bottom, toView: view, attribute: attribute, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    //MARK: centering
    @discardableResult
    public func centerX(to view: Any?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .centerX, toView: view, attribute: .centerX, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func centerY(to view: Any?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .centerY, toView: view, attribute: .centerY, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func center(to view: Any?) -> [NSLayoutConstraint] {
        let centerXConstraint = centerX(to: view)
        let centerYConstraint = centerY(to: view)
        let constraints = [centerXConstraint, centerYConstraint]
        
        return constraints
    }
    
    //MARK: measurement
    @discardableResult
    public func width(to view: Any?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .width, toView: view, attribute: .width, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func width(to view: Any?, multiplier: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .width, toView: view, attribute: .width, relation: .equal, constant: 1, multiplier: multiplier)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func width(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .width, toView: nil, attribute: .width, relation: .equal, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func height(to view: Any?, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .height, toView: view, attribute: .height, relation: relation, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    @discardableResult
    public func height(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint = makeConstraint(attribute: .height, toView: nil, attribute: .height, relation: .equal, constant: constant)
        addConstraintToSuperview(constraint)
        return constraint
    }
    
    
    //MARK: private
    fileprivate func addConstraintToSuperview(_ constraint: NSLayoutConstraint) {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.superview?.addConstraint(constraint)
    }
    
    fileprivate func makeConstraint(attribute attr1: NSLayoutConstraint.Attribute, toView: Any?,
                attribute attr2: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation,
                constant: CGFloat, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self.view,
            attribute: attr1,
            relatedBy: relation,
            toItem: toView,
            attribute: attr2,
            multiplier: multiplier,
            constant: constant)
        
        return constraint
    }
}
