//
//  CartSummaryCell.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import RxSwift

class CartSummaryCell: UITableViewCell {
    static let reuseIdentifier = "CartSummaryCell"
    private(set) var cartSummaryView: CartSummaryView!
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
        cartSummaryView.prepareForReuse()
        disposeBag = DisposeBag()
    }

    private func setupView() {
        cartSummaryView = CartSummaryView(frame: .zero)
        cartSummaryView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cartSummaryView)
        cartSummaryView.pinToParent()
    }
}
