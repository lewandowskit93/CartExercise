//
//  UIButton+AnimateOnPress.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import UIKit
import RxSwift
import RxCocoa

extension UIButton {
    func animateWhenPressed(disposeBag: DisposeBag, pressedDownTransform: CGAffineTransform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)) {
        let onPressDownTransformObservable = rx.controlEvent([.touchDown, .touchDragEnter])
            .map({ pressedDownTransform })
        let onPressUpTransformObservable = rx.controlEvent([.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
            .map({ CGAffineTransform.identity })
        
        Observable.merge(onPressDownTransformObservable, onPressUpTransformObservable)
            .distinctUntilChanged()
            .subscribe(onNext: animate(_:))
            .disposed(by: disposeBag)
    }
        
    private func animate(_ transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = transform
            }, completion: nil)
    }
}
