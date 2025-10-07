//
//  ShopView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import UIKit
import DependencyInjection

class ShopView: UIView, PAppStylable {    
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
        self.backgroundColor = style.lightBackgroundColor
    }
    
    private func buildViewHierarchy() {
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
