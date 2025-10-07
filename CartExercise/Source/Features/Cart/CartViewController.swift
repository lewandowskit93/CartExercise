//
//  CartViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import RxSwift
import RxCocoa
import CartCore

class CartViewController: UIViewController, UITableViewDelegate {
    private var cartView: CartView! { view as? CartView }
    private var viewModel: PCartViewModel
    private let disposeBag: DisposeBag
    private var navbarDisposeBag: DisposeBag
    
    init(viewModel: PCartViewModel) {
        self.viewModel = viewModel
        self.disposeBag = DisposeBag()
        self.navbarDisposeBag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CartView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        subscribeViewModel()
        subscribeView()
        viewModel.onViewLoaded()
    }
    
    private func configureTableView() {
        cartView.contentView.tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.reuseIdentifier)
        cartView.contentView.tableView.register(CartSummaryCell.self, forCellReuseIdentifier: CartSummaryCell.reuseIdentifier)
        cartView.contentView.tableView.dataSource = nil
        cartView.contentView.tableView.delegate = nil
    }
    
    private func subscribeViewModel() {
        if let tabBarItem = tabBarItem {
            viewModel.titleObservable
                .observe(on: MainScheduler.instance)
                .bind(to: tabBarItem.rx.title).disposed(by: disposeBag)
            viewModel.iconObservable
                .observe(on: MainScheduler.instance)
                .bind(to: tabBarItem.rx.image).disposed(by: disposeBag)
        }
        
        viewModel.titleObservable
            .observe(on: MainScheduler.instance)
            .bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        viewModel
            .stateObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.cartView.applyState(state: $0)
                self?.updateNavbarWith(state: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel.stateObservable
            .map { $0.sectionItems }
            .observe(on: MainScheduler.instance)
            .bind(to: cartView.contentView.tableView.rx.items) { (tableView: UITableView, row: Int, sectionItem: CartSectionItem) -> UITableViewCell in
                switch(sectionItem) {
                case .item(let vm):
                    let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.reuseIdentifier, for: IndexPath(row: row, section: 0)) as! CartItemCell
                    cell.cartItemView.configure(with: vm)
                    cell.cartItemView.deleteFromCartButton
                        .rx.tap
                        .observe(on: MainScheduler.instance)
                        .subscribe(onNext: { [unowned self] in
                            self.viewModel.onRemoveFromCartTapped(cartItem: CartItem(offerId: vm.offer.offerId, quantity: Int(vm.quantity)))
                        }).disposed(by: cell.disposeBag)
                    cell.cartItemView.quantityStepper
                        .rx.value
                        .skip(1)
                        .distinctUntilChanged()
                        .subscribe(onNext: { [unowned self] val in
                            if(val > vm.quantity) {
                                self.viewModel.onAddToCartTapped(cartItem: CartItem(offerId: vm.offer.offerId, quantity: Int(val - vm.quantity)))
                            } else {
                                self.viewModel.onRemoveFromCartTapped(cartItem: CartItem(offerId: vm.offer.offerId, quantity: Int(vm.quantity - val)))
                            }
                        }).disposed(by: cell.disposeBag)
                    return cell
                case .summary(let vm):
                    let cell = tableView.dequeueReusableCell(withIdentifier: CartSummaryCell.reuseIdentifier, for: IndexPath(row: row, section: 0)) as! CartSummaryCell
                    cell.cartSummaryView.configure(withViewModel: vm)
                    return cell
                }
            }.disposed(by: disposeBag)
    }
    
    private func subscribeView() {
        cartView.contentView.checkoutButton.animateWhenPressed(disposeBag: disposeBag)
        cartView.contentView.checkoutButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.viewModel.onGoToCheckoutTapped()
        }).disposed(by: disposeBag)
    }
    
    private func updateNavbarWith(state: CartViewState) {
        navbarDisposeBag = DisposeBag()
        switch(state) {
            case .content:
            let changeCurrency = UIBarButtonItem(image: UIImage(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
            let clearCartItem = UIBarButtonItem(image: UIImage(systemName: "trash")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
            changeCurrency.rx.tap
                .withLatestFrom(
                    Observable.combineLatest(viewModel.availableCurrenciesObservable, viewModel.currentCurrencyObservable)
                )
                .subscribe(onNext: { [unowned self] availableCurrencies, currentCurrency in
                    let pickerVM = CurrencyPickerViewModel(currentCurrency: currentCurrency, availableCurrencies: availableCurrencies)
                    let pickerVC = CurrencyPickerViewController(viewModel: pickerVM)
                    pickerVC.modalPresentationStyle = .pageSheet
                    if let sheet = pickerVC.sheetPresentationController {
                        sheet.detents = [.medium()]   // or [.medium(), .large()]
                        sheet.prefersGrabberVisible = true
                    }
                    
                    pickerVM.onPickedCurrencySubject
                        .subscribe(
                            onNext: { [unowned self] currency in
                                pickerVC.dismiss(animated: true)
                                self.viewModel.onChangeCurrency(currency)
                            }
                        ).disposed(by: navbarDisposeBag)

                    self.present(pickerVC, animated: true)
            }).disposed(by: navbarDisposeBag)
            clearCartItem.rx.tap.subscribe(onNext: { [weak self] in
                self?.viewModel.onClearCartTapped()
            }).disposed(by: navbarDisposeBag)
            navigationItem.setRightBarButtonItems([changeCurrency, clearCartItem], animated: true)
            default:
                navigationItem.setRightBarButtonItems([], animated: true)
        }
    }
}
