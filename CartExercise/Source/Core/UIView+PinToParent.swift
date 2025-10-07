//
//  UIView+PinToParent.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit

extension UIView {
    func pinToParent(withPadding padding: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
