//
//  HomeViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import RxSwift

protocol PHomeViewModel {
    var appStyleObservable: Observable<PAppStyle> { get }

    func onViewLoaded()
}

class HomeViewModel: PHomeViewModel, PHasDIContainer, PInitiableWithDIContainer {
    let diContainer: DependencyInjection.PDIContainer
    
    @Inject(.enclosingInstance)
    private var appStyle: PAppStyle
    
    var appStyleObservable: Observable<PAppStyle> {
        appStyleSubject
    }
    
    private var appStyleSubject: ReplaySubject<PAppStyle> = ReplaySubject.create(bufferSize: 1)

    required init(diContainer: DependencyInjection.PDIContainer) {
        self.diContainer = diContainer
    }
    
    func onViewLoaded() {
        appStyleSubject.onNext(appStyle)
    }
}
