//
//  CartItemCell.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import RxSwift

class CartItemCell: UITableViewCell {
    static let reuseIdentifier = "CartItemCell"
    private(set) var cartItemView: CartItemView!
    private(set) var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cartItemView.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let buttonPoint = cartItemView.deleteFromCartButton.convert(point, from: self)
        
        if(cartItemView.deleteFromCartButton.bounds.contains(buttonPoint)) {
            return cartItemView.deleteFromCartButton
        }
        
        let stepperPoint = cartItemView.quantityStepper.convert(point, from: self)
        
        if(cartItemView.quantityStepper.bounds.contains(stepperPoint)) {
            return cartItemView.quantityStepper
        }
        
        return super.hitTest(point, with: event)
    }

    private func setupView() {
        cartItemView = CartItemView(frame: .zero)
        cartItemView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cartItemView)
        cartItemView.pinToParent()
    }
}
