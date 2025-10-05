//
//  CartView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import DependencyInjection

class CartView: UIView, PAppStylable {
    private(set) var cartIdView: UILabel!
    
    @Inject(.fixed(DepsContainers.cartApp))
    private var style: PAppStyle
    
    @Inject(.fixed(DepsContainers.cartApp))
    private var factories: PUIFactories
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        applyStyle(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Should not be called")
    }
    
    func applyStyle(style: PAppStyle) {
        self.style = style
        self.backgroundColor = style.backgroundColor
        cartIdView.textColor = style.primaryColor
        cartIdView.font = style.propertyNameFont
    }
    
    private func buildViewHierarchy() {
        cartIdView = factories.createLabel()
        addSubview(cartIdView)
    }
    
    private func setupConstraints() {
        let constraints = [
            cartIdView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cartIdView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cartIdView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            cartIdView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
