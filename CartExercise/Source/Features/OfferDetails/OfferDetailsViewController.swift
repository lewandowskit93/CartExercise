//
//  OfferDetailsViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import UIKit
import RxSwift
import RxCocoa

class OfferDetailsViewController: UIViewController {
    private var viewModel: POfferDetailsViewModel
    private let disposeBag: DisposeBag
    private var detailsView: OfferDetailsView! { view as? OfferDetailsView }
    
    init(viewModel: POfferDetailsViewModel) {
        self.viewModel = viewModel
        self.disposeBag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = OfferDetailsView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModel()
        subscribeView()
        viewModel.onViewLoaded()
    }
    
    private func subscribeViewModel() {
        viewModel.titleObservable
            .observe(on: MainScheduler.instance)
            .bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        viewModel.itemNameObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.nameView.rx.text).disposed(by: disposeBag)
        viewModel.itemDescriptionTitleObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.descriptionTitleView.rx.text).disposed(by: disposeBag)
        viewModel.itemDescriptionObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.descriptionValueView.rx.text).disposed(by: disposeBag)
        viewModel.itemPriceObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.priceView.rx.text).disposed(by: disposeBag)
        viewModel.stockObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.stockView.rx.text).disposed(by: disposeBag)
        viewModel.inStockCountObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.quantityStepperView.rx.maximumValue).disposed(by: disposeBag)
        viewModel.outOfStockObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.addToCartButton.rx.isHidden).disposed(by: disposeBag)
        viewModel.addToCartButtonTitleObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.addToCartButton.rx.title()).disposed(by: disposeBag)
        viewModel.addToCartButtonImageObservable
            .observe(on: MainScheduler.instance)
            .bind(to: detailsView.addToCartButton.rx.image()).disposed(by: disposeBag)
    }
    
    
    
    private func subscribeView() {
        detailsView.quantityStepperView.rx.value
            .observe(on: MainScheduler.instance)
            .map { String(format: "%.0f", $0) }
            .bind(to: detailsView.quantityView.rx.text)
            .disposed(by: disposeBag)
        
        detailsView.quantityStepperView.rx.value
            .observe(on: MainScheduler.instance)
            .map { $0 > 0 }
            .bind(to: detailsView.addToCartButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        detailsView.addToCartButton.animateWhenPressed(disposeBag: disposeBag, pressedDownTransform: .identity.scaledBy(x: 1.4, y: 1.4))
        detailsView.addToCartButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.viewModel.onAddToCartTapped(quantity: self.detailsView.quantityStepperView.value)
        }).disposed(by: disposeBag)

    }
}
