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

    private func setupView() {
        cartItemView = CartItemView(frame: .zero)
        cartItemView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cartItemView)
        cartItemView.pinToParent()
    }
}
