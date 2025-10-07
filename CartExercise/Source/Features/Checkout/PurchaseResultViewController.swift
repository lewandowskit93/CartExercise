//
//  PurchaseResultViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 07/10/2025.
//

import UIKit
import RxSwift
import RxCocoa

class PurchaseResultViewController: UIViewController {
    private let viewModel: PurchaseResultViewModel
    private let disposeBag: DisposeBag
    private var resultView: PurchaseResultView! { view as? PurchaseResultView }
    private let coordinator: PCheckoutCoordinator
    
    init(viewModel: PurchaseResultViewModel, coordinator: PCheckoutCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.disposeBag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PurchaseResultView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
    
    private func subscribe() {
        if let tabBarItem = tabBarItem {
            viewModel.titleObservable
                .observe(on: MainScheduler.instance)
                .bind(to: tabBarItem.rx.title)
                .disposed(by: disposeBag)
        }
        
        viewModel.titleObservable
            .observe(on: MainScheduler.instance)
            .bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        viewModel.messageObservable
            .observe(on: MainScheduler.instance)
            .bind(to: resultView.resultText.rx.text).disposed(by: disposeBag)

        resultView.finishButton
            .rx
            .tap
            .subscribe(onNext: { [unowned self] in
                self.coordinator.finishFlow()
            }).disposed(by: disposeBag)
    }
}
