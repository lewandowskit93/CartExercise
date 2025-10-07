//
//  ShopItemView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import DependencyInjection

class ShopItemView: UIView, PAppStylable {
    private(set) var imageView: UIImageView!
    private(set) var nameView: UILabel!
    private(set) var contentStack: UIStackView!
    private(set) var infoStack: UIStackView!
    private(set) var priceView: UILabel!
    private(set) var stockView: UILabel!
    private(set) var addToCartButton: UIButton!
    
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
        self.nameView.font = style.property1NameFont
        self.nameView.textColor = style.primaryColor
        self.priceView.font = style.property2ValueFont
        self.stockView.font = style.property2ValueFont
        self.addToCartButton.tintColor = style.quickActionColor
        self.addToCartButton.titleLabel?.font = style.quickActionFont
        self.addToCartButton.setTitleColor(style.quickActionColor, for: .normal)
        self.addToCartButton.backgroundColor = style.quickActionBackgroundColor
    }
    
    func configure(with viewModel: ShopItemViewModel, style itemViewStyle: ShopItemViewStyle) {
        self.nameView.text = viewModel.name
        self.priceView.text = viewModel.price
        self.stockView.text = viewModel.stock
        self.addToCartButton.isHidden = !viewModel.addToCartButtonVisible
        self.addToCartButton.setImage(viewModel.addToCartButtonIcon, for: .normal)
        self.addToCartButton.setTitle(viewModel.addToCartButtonTitle, for: .normal)
        self.addToCartButton.isHidden = !viewModel.addToCartButtonVisible
        self.backgroundColor = itemViewStyle.isLight ? style.lightBackgroundColor : style.darkBackgroundColor
        self.priceView.textColor = itemViewStyle.isLight ? style.secondaryColor : style.primaryColor
        self.stockView.textColor = itemViewStyle.isLight ? style.secondaryColor : style.primaryColor
    }
    
    func prepareForReuse() {
        imageView.image = nil
        nameView.text = nil
        stockView.text = nil
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
        stockView = factories.createLabel()
        addToCartButton = factories.createButton()
        addToCartButton.layer.cornerRadius = 16
    }
    
    private func buildViewHierarchy() {
        addSubview(contentStack)
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(nameView)
        infoStack.addArrangedSubview(priceView)
        infoStack.addArrangedSubview(stockView)
        infoStack.addArrangedSubview(addToCartButton)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            addToCartButton.heightAnchor.constraint(equalToConstant: 32)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
