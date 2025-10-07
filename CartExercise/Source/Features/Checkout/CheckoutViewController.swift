//
//  CheckoutViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import UIKit
import RxSwift
import RxCocoa

class CheckoutViewController: UIViewController {
    private var checkoutView: CheckoutView! { view as? CheckoutView }
    private let viewModel: PCheckoutViewModel
    private let disposeBag: DisposeBag
    
    init(viewModel: PCheckoutViewModel) {
        self.viewModel = viewModel
        self.disposeBag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CheckoutView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        subscribe()
        viewModel.onViewLoaded()
        setupNavbar()
    }
    
    private func configureTableView() {
        checkoutView.tableView.register(CheckoutItemCell.self, forCellReuseIdentifier: CheckoutItemCell.reuseIdentifier)
        checkoutView.tableView.register(CheckoutSummaryCell.self, forCellReuseIdentifier: CheckoutSummaryCell.reuseIdentifier)
        checkoutView.tableView.dataSource = nil
        checkoutView.tableView.delegate = nil
    }
    
    private func subscribe() {
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
        
        viewModel.sectionItemsObservable
            .observe(on: MainScheduler.instance)
            .bind(to: checkoutView.tableView.rx.items) { (tableView: UITableView, row: Int, sectionItem: CheckoutSectionItem) -> UITableViewCell in
                switch(sectionItem) {
                case .item(let vm):
                    let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutItemCell.reuseIdentifier, for: IndexPath(row: row, section: 0)) as! CheckoutItemCell
                    cell.cartItemView.configure(with: vm)
                    return cell
                case .summary(let vm):
                    let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutSummaryCell.reuseIdentifier, for: IndexPath(row: row, section: 0)) as! CheckoutSummaryCell
                    cell.cartSummaryView.configure(withViewModel: vm)
                    return cell
                }
            }.disposed(by: disposeBag)
        
        checkoutView.finishButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.viewModel.onFinishTapped()
        }).disposed(by: disposeBag)
    }
    
    private func setupNavbar() {
        let changeCurrency = UIBarButtonItem(image: UIImage(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
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
                    ).disposed(by: disposeBag)
                
                self.present(pickerVC, animated: true)
            }).disposed(by: disposeBag)
        navigationItem.setRightBarButtonItems([changeCurrency], animated: true)
    }
}
