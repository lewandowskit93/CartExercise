//
//  PAppStyle.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit

protocol PAppStyle {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var secondaryBackgroundColor: UIColor { get }
    var titleFont: UIFont { get }
    var subtitleFont: UIFont { get }
    var propertyNameFont: UIFont { get }
    var propertyValueFont: UIFont { get }
    var descriptionFont: UIFont { get }
}
