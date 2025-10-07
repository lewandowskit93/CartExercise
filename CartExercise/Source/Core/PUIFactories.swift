//
//  PUIFactories.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit

protocol PUIFactories {
    func createTabeView() -> UITableView
    func createEmptyView() -> EmptyView
    func createLoadingView() -> LoadingView
    func createImageView() -> UIImageView
    func createLabel() -> UILabel
    func createText() -> UITextView
    func createButton() -> UIButton
    func createView() -> UIView
    func createStepper() -> UIStepper
    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView
    func createScrollView() -> UIScrollView

}
