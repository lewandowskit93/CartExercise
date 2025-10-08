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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shopItemView.prepareForReuse()
        disposeBag = DisposeBag()
    }

    private func setupView() {
        shopItemView = ShopItemView(frame: .zero)
        shopItemView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shopItemView)
        shopItemView.pinToParent()
    }
}
