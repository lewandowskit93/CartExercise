//
//  UIView+PinToParent.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit

extension UIView {
    func pinToParent() {
        guard let superview = self.superview else { return }
        let constraints = [
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
