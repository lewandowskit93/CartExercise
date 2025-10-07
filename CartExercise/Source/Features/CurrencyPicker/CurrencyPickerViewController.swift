//
//  CurrencyPickerViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import CartCore
import RxSwift
import RxCocoa

class CurrencyPickerViewController: UIViewController {
    private var pickerView: UIPickerView! { view as? UIPickerView }
    private let viewModel: CurrencyPickerViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: CurrencyPickerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIPickerView(frame: .zero)
        setupPickerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        let currentCurrencyRow = viewModel.availableCurrencies.firstIndex(of: viewModel.currentCurrency) ?? 0
        pickerView.selectRow(currentCurrencyRow, inComponent: 0, animated: true)
    }

    private func setupPickerView() {
        pickerView.dataSource = nil
        pickerView.delegate = nil
    }
    
    private func subscribe() {
        Observable.just(viewModel.availableCurrencies)
            .observe(on: MainScheduler.instance)
            .bind(to: pickerView.rx.itemTitles) { r, v in
                return v.rawValue
            }
            .disposed(by: disposeBag)
        pickerView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .map { $0.row }
            .map { [unowned self] in self.viewModel.availableCurrencies[$0] }
            .bind(to: viewModel.onPickedCurrencySubject)
            .disposed(by: disposeBag)
    }
}
