//
//  CheckoutView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import UIKit
import DependencyInjection

class CheckoutView: UIView, PAppStylable {
    private(set) var tableView: UITableView!
    private(set) var finishButton: UIButton!

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
        finishButton.backgroundColor = style.primaryActionBackgroundColor
        finishButton.setTitleColor(style.primaryActionColor, for: .normal)
        finishButton.layer.cornerRadius = 24.0
        finishButton.titleLabel?.font = style.primaryActionFont
    }
    
    private func createViews() {
        tableView = factories.createTabeView()
        finishButton = factories.createButton()
        finishButton.setTitle("Proceed", for: .normal)

    }
    
    private func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(finishButton)
    }
    
    private func setupConstraints() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            finishButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 64),
            finishButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -64),
            finishButton.heightAnchor.constraint(equalToConstant: 48),
            finishButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]
        tableView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
        NSLayoutConstraint.activate(constraints)
    }
}

