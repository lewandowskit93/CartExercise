//
//  CartContentView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import DependencyInjection

class CartContentView: UIView, PAppStylable {
    private(set) var tableView: UITableView!
    private(set) var checkoutButton: UIButton!
    
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
        tableView.backgroundColor = nil
        checkoutButton.backgroundColor = style.primaryActionBackgroundColor
        checkoutButton.setTitleColor(style.primaryActionColor, for: .normal)
        checkoutButton.layer.cornerRadius = 24.0
        checkoutButton.titleLabel?.font = style.primaryActionFont
    }
    
    private func createViews() {
        tableView = factories.createTabeView()
        checkoutButton = factories.createButton()
        checkoutButton.setTitle("Checkout", for: .normal)
    }
    
    private func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            checkoutButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 64),
            checkoutButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -64),
            checkoutButton.heightAnchor.constraint(equalToConstant: 48),
            checkoutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]
        tableView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
        NSLayoutConstraint.activate(constraints)
    }
}
