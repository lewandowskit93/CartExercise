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
    let primaryActionColor = UIColor.orange
    let primaryActionBackgroundColor = UIColor(red: toFloat(32), green: toFloat(42), blue: toFloat(68), alpha: 1.0)
    let secondaryActionColor = UIColor.orange
    let secondaryActionBackgroundColor = UIColor.blue
    let quickActionColor = UIColor(red: toFloat(32), green: toFloat(42), blue: toFloat(68), alpha: 1.0)
    let disabledActionColor = UIColor.lightGray
    let quickActionBackgroundColor = UIColor.orange
    let selectedItemColor = UIColor.orange
    let unselectedItemColor = UIColor.white
    let disabledItemColor = UIColor.gray
    let darkBackgroundColor = UIColor(red: toFloat(32), green: toFloat(42), blue: toFloat(68), alpha: 1.0)
    let lightBackgroundColor = UIColor.cyan
    
    let titleFont = UIFont.systemFont(ofSize: 30.0, weight: .bold)
    let header1Font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
    let header2Font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
    let header3Font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
    let subtitleFont = UIFont.systemFont(ofSize: 24.0, weight: .semibold)
    let largeNavbarTitleFont = UIFont.systemFont(ofSize: 24.0, weight: .semibold)
    let navbarTitleFont = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    let property1NameFont = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    let property1ValueFont = UIFont.italicSystemFont(ofSize: 16.0)
    let property2NameFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    let property2ValueFont = UIFont.italicSystemFont(ofSize: 12.0)
    let property3NameFont = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
    let property3ValueFont = UIFont.italicSystemFont(ofSize: 8.0)
    
    let descriptionFont = UIFont.systemFont(ofSize: 18.0, weight: .regular)
    let primaryActionFont = UIFont.systemFont(ofSize: 24.0, weight: .bold)
    let secondaryActionFont = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    let quickActionFont = UIFont.systemFont(ofSize: 18.0, weight: .semibold)

    private static func toFloat(_ component: CGFloat) -> CGFloat { return component/256.0 }
}
