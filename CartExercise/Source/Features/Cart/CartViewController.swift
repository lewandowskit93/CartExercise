//
//  CartViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController {
    private var cartView: CartView! { view as? CartView }
    private var viewModel: PCartViewModel
    private let disposeBag: DisposeBag
    
    init(viewModel: PCartViewModel) {
        self.viewModel = viewModel
        self.disposeBag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CartView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        viewModel.onViewLoaded()
    }
    
    private func subscribe() {
        viewModel
            .cardIdObservable
            .bind(to: cartView.cartIdView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .cardIdObservable
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
    }
}
