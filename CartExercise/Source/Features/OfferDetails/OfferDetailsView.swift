//
//  OfferDetailsView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import UIKit
import DependencyInjection

class OfferDetailsView: UIView, PAppStylable {
    private(set) var imageView: UIImageView!
    private(set) var nameView: UILabel!
    private(set) var priceView: UILabel!
    private(set) var stockView: UILabel!
    private(set) var quantityView: UILabel!
    private(set) var addToCartButton: UIButton!
    private(set) var descriptionStackView: UIStackView!
    private(set) var descriptionTitleView: UILabel!
    private(set) var descriptionValueView: UILabel!
    private(set) var quantityStepperView: UIStepper!
    private var mainStackView: UIStackView!
    private var basicItemDataStackView: UIStackView!
    private var infoStackView: UIStackView!
    private var scrollView: UIScrollView!
    private var descriptionTitleContainerView: UIView!
    private var descriptionValueContainerView: UIView!
    private var addToCartButtonContainerView: UIView!
    private var cartStackView: UIStackView!
    private var quantityStackView: UIStackView!



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
        nameView.font = style.subtitleFont
        nameView.textColor = style.primaryColor
        priceView.font = style.property1ValueFont
        priceView.textColor = style.secondaryColor
        stockView.font = style.property2ValueFont
        stockView.textColor = style.secondaryColor
        addToCartButton.backgroundColor = style.quickActionBackgroundColor
        addToCartButton.setTitleColor(style.quickActionColor, for: .normal)
        addToCartButton.setTitleColor(style.disabledItemColor, for: .disabled)
        addToCartButton.layer.cornerRadius = 18.0
        addToCartButton.titleLabel?.font = style.primaryActionFont
        addToCartButton.tintColor = style.quickActionColor
        descriptionTitleView.font = style.header1Font
        descriptionTitleView.textColor = style.primaryColor
        descriptionTitleContainerView.backgroundColor = style.darkBackgroundColor
        descriptionValueView.font = style.descriptionFont
        descriptionValueView.textColor = style.secondaryColor
        self.backgroundColor = style.lightBackgroundColor
    }
    
    private func createViews() {
        imageView = factories.createImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        scrollView = factories.createScrollView()
        scrollView.contentInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 24, right: 0)
        mainStackView = factories.createStackView(axis: .vertical)
        mainStackView.spacing = 10.0
        mainStackView.alignment = .fill
        basicItemDataStackView = factories.createStackView(axis: .horizontal)
        basicItemDataStackView.spacing = 12
        basicItemDataStackView.isLayoutMarginsRelativeArrangement = true
        basicItemDataStackView.layoutMargins = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        infoStackView = factories.createStackView(axis: .vertical)
        infoStackView.spacing = 16.0
        infoStackView.alignment = .fill
        nameView = factories.createLabel()
        priceView = factories.createLabel()
        cartStackView = factories.createStackView(axis: .vertical)
        cartStackView.spacing = 4.0
        cartStackView.alignment = .fill
        quantityStackView = factories.createStackView(axis: .horizontal)
        quantityStackView.distribution = .fillEqually
        quantityView = factories.createLabel()
        quantityStepperView = factories.createStepper()
        quantityStepperView.minimumValue = 0
        quantityStepperView.stepValue = 1.0
        stockView = factories.createLabel()
        addToCartButtonContainerView = factories.createView()
        addToCartButton = factories.createButton()
        descriptionStackView = factories.createStackView(axis: .vertical)
        descriptionStackView.spacing = 8.0
        descriptionStackView.alignment = .fill
        descriptionTitleContainerView = factories.createView()
        descriptionTitleView = factories.createLabel()
        descriptionValueContainerView = factories.createView()
        descriptionValueView = factories.createLabel()
        descriptionValueView.backgroundColor = .clear
        descriptionValueView.lineBreakMode = .byWordWrapping
        descriptionValueView.numberOfLines = 0
    }
    
    private func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(basicItemDataStackView)
        mainStackView.addArrangedSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(descriptionTitleContainerView)
        descriptionTitleContainerView.addSubview(descriptionTitleView)
        descriptionStackView.addArrangedSubview(descriptionValueContainerView)
        descriptionValueContainerView.addSubview(descriptionValueView)
        basicItemDataStackView.addArrangedSubview(imageView)
        basicItemDataStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(nameView)
        infoStackView.addArrangedSubview(cartStackView)
        cartStackView.addArrangedSubview(quantityStackView)
        quantityStackView.addArrangedSubview(quantityView)
        quantityStackView.addArrangedSubview(quantityStepperView)
        cartStackView.addArrangedSubview(stockView)
        cartStackView.addArrangedSubview(addToCartButtonContainerView)
        addToCartButtonContainerView.addSubview(addToCartButton)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(
                equalTo: self.scrollView.widthAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            addToCartButton.heightAnchor.constraint(equalToConstant: 36)
        ]
        NSLayoutConstraint.activate(constraints)
        descriptionTitleView.pinToParent(withPadding: .init(top: 4, left: 8, bottom: 4, right: 8))
        descriptionValueView.pinToParent(withPadding: .init(top: 0, left: 8, bottom: 0, right: 8))
        addToCartButton.pinToParent()
    }
}
