//
//  AppRootViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import RxSwift
import RxCocoa

class AppRootViewController: UIViewController {
    private var viewModel: PAppViewModel
    private var coordinator: PAppRootCoordinator
    private let disposeBag: DisposeBag
    
    init(viewModel: PAppViewModel, coordinator: PAppRootCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.disposeBag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModel()
        viewModel.onViewLoaded()
        coordinator.openHome()
    }
    
    private func subscribeViewModel() {
        viewModel.appStyleObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] style in
                guard let self = self else { return }
                self.view.backgroundColor = style.darkBackgroundColor
            })
            .disposed(by: disposeBag)
    }
}
