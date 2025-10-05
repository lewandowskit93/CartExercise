//
//  DefaultAppStyle.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import UIKit

struct DefaultAppStyle: PAppStyle {
    let primaryColor = UIColor.orange
    let secondaryColor = UIColor.black
    let backgroundColor = UIColor(red: toFloat(32), green: toFloat(42), blue: toFloat(68), alpha: 1.0)
    let secondaryBackgroundColor = UIColor.cyan
    let titleFont = UIFont.systemFont(ofSize: 30.0, weight: .bold)
    let subtitleFont = UIFont.systemFont(ofSize: 24.0, weight: .semibold)
    let propertyNameFont = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    let propertyValueFont = UIFont.systemFont(ofSize: 18.0, weight: .regular)
    let descriptionFont = UIFont.systemFont(ofSize: 18.0, weight: .regular)
    
    private static func toFloat(_ component: CGFloat) -> CGFloat { return component/256.0 }
}
