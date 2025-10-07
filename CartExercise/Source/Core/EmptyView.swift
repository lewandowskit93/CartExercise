//
//  EmptyView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import DependencyInjection

class EmptyView: UIView, PAppStylable {
    private(set) var captionView: UILabel!
    
    @Inject(.fixed(DepsContainers.cartApp))
    private var style: PAppStyle
    
    @Inject(.fixed(DepsContainers.cartApp))
    private var factories: PUIFactories
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
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
        captionView.textColor = style.primaryColor
        captionView.font = style.property1NameFont
    }
    
    private func createViews() {
        captionView = factories.createLabel()
    }
    
    private func buildViewHierarchy() {
        addSubview(captionView)
    }
    
    private func setupConstraints() {
        let constraints = [
            captionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            captionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            captionView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            captionView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
