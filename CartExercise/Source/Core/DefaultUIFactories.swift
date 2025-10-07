//
//  DefaultUIFactories.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit

class DefaultUIFactories: PUIFactories {
    func createTabeView() -> UITableView {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createEmptyView() -> EmptyView {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createLoadingView() -> LoadingView {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createStepper() -> UIStepper {
        let view = UIStepper()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }
    
    func createImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createText() -> UITextView {
        let view = UITextView()
        view.textContainer.lineBreakMode = .byWordWrapping
        view.isScrollEnabled = false
        view.textContainer.lineBreakMode = .byWordWrapping
        return view
    }
    
    func createStackView(axis: NSLayoutConstraint.Axis = .vertical) -> UIStackView {
        let view = UIStackView()
        view.alignment = .leading
        view.axis = axis
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createButton() -> UIButton {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view;
    }
    
    func createLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view;
    }

}

