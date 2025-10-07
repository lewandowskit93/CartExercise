//
//  PurchaseResultView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import DependencyInjection

class PurchaseResultView: UIView, PAppStylable {
    private(set) var finishButton: UIButton!
    private(set) var resultText: UILabel!
    
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
        finishButton.tintColor = style.primaryActionColor
        finishButton.setTitleColor(style.primaryActionColor, for: .normal)
        finishButton.titleLabel?.font = style.primaryActionFont
        finishButton.backgroundColor = style.primaryActionBackgroundColor
        finishButton.layer.cornerRadius = 32
        resultText.textColor = style.primaryColor
    }
    
    private func createViews() {
        finishButton = factories.createButton()
        finishButton.setTitle("Ok", for: .normal)
        resultText = factories.createLabel()
    }
    
    private func buildViewHierarchy() {
        addSubview(resultText)
        addSubview(finishButton)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            resultText.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            resultText.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            resultText.centerXAnchor.constraint(equalTo: centerXAnchor),
            resultText.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            finishButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            finishButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            finishButton.widthAnchor.constraint(equalToConstant: 240),
            finishButton.heightAnchor.constraint(equalToConstant: 64)

        ]
        NSLayoutConstraint.activate(constraints)
    }
}
