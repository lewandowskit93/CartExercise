//
//  CheckoutItemCell.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import RxSwift

class CheckoutItemCell: UITableViewCell {
    static let reuseIdentifier = "CheckoutItemCell"
    private(set) var cartItemView: CheckoutItemView!
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
        cartItemView = CheckoutItemView(frame: .zero)
        cartItemView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cartItemView)
        cartItemView.pinToParent()
    }
}
