//
//  CheckoutItemView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import DependencyInjection
import CartCore

class CheckoutItemView: UIView, PAppStylable {
    private(set) var imageView: UIImageView!
    private(set) var nameView: UILabel!
    private(set) var contentStack: UIStackView!
    private(set) var infoStack: UIStackView!
    private(set) var priceView: UILabel!
    private(set) var quantityStack: UIStackView!
    private(set) var quantityView: UILabel!
    
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
        self.nameView.font = style.property1NameFont
        self.nameView.textColor = style.primaryColor
        self.priceView.font = style.property2ValueFont
        self.quantityView.font = style.property2ValueFont
    }
    
    func configure(with viewModel: CheckoutItemViewModel) {
        self.nameView.text = viewModel.name
        self.priceView.text = viewModel.price
        self.quantityView.text = viewModel.quantityString
    }
    
    func prepareForReuse() {
        imageView.image = nil
        nameView.text = nil
        quantityView.text = nil
        priceView.text = nil
    }
    
    private func createViews() {
        contentStack = factories.createStackView(axis: .horizontal)
        contentStack.spacing = 24
        imageView = factories.createImageView()
        imageView.backgroundColor = UIColor.white
        infoStack = factories.createStackView(axis: .vertical)
        infoStack.alignment = .fill
        infoStack.spacing = 12
        nameView = factories.createLabel()
        priceView = factories.createLabel()
        quantityStack = factories.createStackView(axis: .horizontal)
        quantityView = factories.createLabel()
    }
    
    private func buildViewHierarchy() {
        addSubview(contentStack)
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(nameView)
        infoStack.addArrangedSubview(priceView)
        infoStack.addArrangedSubview(quantityStack)
        quantityStack.addArrangedSubview(quantityView)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
