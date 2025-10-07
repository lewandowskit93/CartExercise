//
//  HomeViewController.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UITabBarController {
    let viewModel: PHomeViewModel
    let coordinator: PHomeCoordinator
    private let disposeBag: DisposeBag
        
    init(viewModel: PHomeViewModel, coordinator: PHomeCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.disposeBag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModel()
        viewModel.onViewLoaded()
    }
    
    private func subscribeViewModel() {
        viewModel.appStyleObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] style in
                guard let self = self else { return }
                self.view.backgroundColor = style.darkBackgroundColor
                tabBar.isTranslucent = false
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                let stackedAppearance = appearance.stackedLayoutAppearance
                stackedAppearance.disabled.iconColor = style.disabledItemColor
                stackedAppearance.disabled.titleTextAttributes = [.foregroundColor: style.disabledItemColor]
                stackedAppearance.normal.iconColor = style.unselectedItemColor
                stackedAppearance.normal.titleTextAttributes = [.foregroundColor: style.unselectedItemColor]
                stackedAppearance.selected.iconColor = style.selectedItemColor
                stackedAppearance.selected.titleTextAttributes = [.foregroundColor: style.selectedItemColor]
                appearance.backgroundColor = style.darkBackgroundColor
                appearance.stackedLayoutAppearance = stackedAppearance
                appearance.inlineLayoutAppearance = stackedAppearance
                appearance.compactInlineLayoutAppearance = stackedAppearance
                tabBar.standardAppearance = appearance
                tabBar.scrollEdgeAppearance = appearance
                tabBar.backgroundColor = style.darkBackgroundColor
            }).disposed(by: disposeBag)
    }
}
