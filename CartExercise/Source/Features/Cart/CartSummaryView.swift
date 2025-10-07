//
//  CartSummaryView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import DependencyInjection

class CartSummaryView: UIView, PAppStylable {
    private(set) var contentStack: UIStackView!
    private(set) var propertyNamesStack: UIStackView!
    private(set) var propertyValuesStack: UIStackView!
    private(set) var uniqueItemsInCartTitle: UILabel!
    private(set) var uniqueItemsInCartValue: UILabel!
    private(set) var totalPriceTitle: UILabel!
    private(set) var totalPriceValue: UILabel!
    
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
        self.backgroundColor = style.darkBackgroundColor
        self.uniqueItemsInCartTitle.textColor = style.primaryColor
        self.uniqueItemsInCartValue.textColor = style.primaryColor
        self.totalPriceTitle.textColor = style.primaryColor
        self.totalPriceValue.textColor = style.primaryColor
        self.uniqueItemsInCartTitle.font = style.property2NameFont
        self.uniqueItemsInCartValue.font = style.property2ValueFont
        self.totalPriceTitle.font = style.property2NameFont
        self.totalPriceValue.font = style.property2ValueFont
    }
    
    func configure(withViewModel viewModel: CartSummaryViewModel) {
        totalPriceTitle.text = viewModel.totalPriceTitle
        totalPriceValue.text = viewModel.totalPriceValue
        uniqueItemsInCartTitle.text = viewModel.uniqueItemsInCartTitle
        uniqueItemsInCartValue.text = viewModel.uniqueItemsInCartValue
    }
    
    func prepareForReuse() {
        totalPriceTitle.text = nil
        totalPriceValue.text = nil
        uniqueItemsInCartTitle.text = nil
        uniqueItemsInCartValue.text = nil
    }
    
    private func createViews() {
        contentStack = factories.createStackView(axis: .horizontal)
        contentStack.spacing = 10
        propertyNamesStack = factories.createStackView(axis: .vertical)
        propertyNamesStack.spacing = 8
        propertyValuesStack = factories.createStackView(axis: .vertical)
        propertyValuesStack.spacing = 8
        totalPriceTitle = factories.createLabel()
        totalPriceValue = factories.createLabel()
        uniqueItemsInCartTitle = factories.createLabel()
        uniqueItemsInCartValue = factories.createLabel()
    }
    
    private func buildViewHierarchy() {
        addSubview(contentStack)
        contentStack.addArrangedSubview(propertyNamesStack)
        propertyNamesStack.addArrangedSubview(totalPriceTitle)
        propertyNamesStack.addArrangedSubview(uniqueItemsInCartTitle)
        contentStack.addArrangedSubview(propertyValuesStack)
        propertyValuesStack.addArrangedSubview(totalPriceValue)
        propertyValuesStack.addArrangedSubview(uniqueItemsInCartValue)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            propertyNamesStack.widthAnchor.constraint(equalTo: contentStack.widthAnchor, multiplier: 0.7)
        ]
        contentStack.pinToParent(withPadding: .init(top: 40, left: 16, bottom: 40, right: 16))
        NSLayoutConstraint.activate(constraints)
    }
}
