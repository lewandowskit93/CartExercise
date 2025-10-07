//
//  ShopItemCell.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import RxSwift

class ShopItemCell: UITableViewCell {
    static let reuseIdentifier = "ShopItemCell"
    private(set) var shopItemView: ShopItemView!
    private(set) var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let buttonPoint = shopItemView.addToCartButton.convert(point, from: self)
        
        if(shopItemView.addToCartButton.bounds.contains(buttonPoint)) {
            return shopItemView.addToCartButton
        }
        
        return super.hitTest(point, with: event)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shopItemView.prepareForReuse()
        disposeBag = DisposeBag()
    }

    private func setupView() {
        shopItemView = ShopItemView(frame: .zero)
        shopItemView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shopItemView)
        shopItemView.pinToParent()
    }
}
