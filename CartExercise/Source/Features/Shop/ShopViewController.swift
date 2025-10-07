//
//  ShopViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import UIKit
import RxSwift
import RxCocoa
import CartCore

class ShopViewController: UITableViewController {
    private var viewModel: PShopViewModel
    private var coordinator: PShopCoordinator
    private let disposeBag: DisposeBag
    
    init(viewModel: PShopViewModel, coordinator: PShopCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 80)
        self.disposeBag = DisposeBag()
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
//    override func loadView() {
//        view = ShopView(frame: .zero)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        subscribeViewModel()
        subscribeView()
        viewModel.onViewLoaded()
    }
    
    private func configureTableView() {
        tableView.register(ShopItemCell.self, forCellReuseIdentifier: ShopItemCell.reuseIdentifier)
        tableView.dataSource = nil
        tableView.delegate = nil
    }
    
    private func subscribeView() {
        tableView.rx.modelSelected(ShopItemViewModel.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] offer in
                self?.coordinator.goToOffer(offer: offer.offer)
            }).disposed(by: disposeBag)
    }
    
    private func subscribeViewModel() {
        viewModel.appStyleObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] style in
                guard let self = self else { return }
                self.tableView.backgroundColor = style.lightBackgroundColor
                self.view.backgroundColor = style.lightBackgroundColor
            }).disposed(by: disposeBag)
        
        if let tabBarItem = tabBarItem {
            viewModel.titleObservable
                .observe(on: MainScheduler.instance)
                .bind(to: tabBarItem.rx.title)
                .disposed(by: disposeBag)
            viewModel.iconObservable
                .observe(on: MainScheduler.instance)
                .bind(to: tabBarItem.rx.image)
                .disposed(by: disposeBag)
        }
        
        viewModel.titleObservable
            .observe(on: MainScheduler.instance)
            .bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        viewModel.offersObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: ShopItemCell.reuseIdentifier, cellType: ShopItemCell.self)) { index, offer, cell in
                let style = index % 2 == 0 ? ShopItemViewStyle.light : ShopItemViewStyle.dark
                cell.shopItemView.configure(with: offer, style: style)
                cell.shopItemView.addToCartButton.animateWhenPressed(disposeBag: cell.disposeBag, pressedDownTransform: .identity.scaledBy(x: 1.3, y: 1.3))
                cell.shopItemView.addToCartButton.rx.tap
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { [weak self] in
                        self?.viewModel.addToCart(offer: offer.offer)
                    }).disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
    }
}
