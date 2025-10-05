//
//  DefaultUIFactories.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit

class DefaultUIFactories: PUIFactories {
    func createLabel() -> UILabel {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view;
    }

}

