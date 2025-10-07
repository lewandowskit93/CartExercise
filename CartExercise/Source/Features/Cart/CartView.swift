//
//  CartView.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import DependencyInjection

class CartView: UIView, PAppStylable {
    private(set) var contentView: CartContentView!
    private(set) var emptyView: EmptyView!
    private(set) var loadingView: LoadingView!

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
    
    func applyState(state: CartViewState) {
        switch(state) {
            case .content:
                contentView.isHidden = false
                emptyView.isHidden = true
                loadingView.isHidden = true
            case .empty(let caption):
                contentView.isHidden = true
                emptyView.isHidden = false
                loadingView.isHidden = true
                emptyView.captionView.text = caption
            case .loading, .loadingOffers:
                contentView.isHidden = true
                emptyView.isHidden = true
                loadingView.isHidden = false
        }
    }
    
    func applyStyle(style: PAppStyle) {
        self.style = style
        self.backgroundColor = style.lightBackgroundColor
        emptyView.applyStyle(style: style)
        loadingView.applyStyle(style: style)
        contentView.applyStyle(style: style)
    }
    
    private func createViews() {
        contentView = CartContentView(frame: .zero)
        emptyView = factories.createEmptyView()
        loadingView = factories.createLoadingView()
    }
    
    private func buildViewHierarchy() {
        addSubview(contentView)
        addSubview(emptyView)
        addSubview(loadingView)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
        ]
        contentView.pinToParent()
        emptyView.pinToParent()
        loadingView.pinToParent()
        NSLayoutConstraint.activate(constraints)
    }
}
