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
    var primaryActionColor: UIColor { get }
    var primaryActionBackgroundColor: UIColor { get }
    var secondaryActionColor: UIColor { get }
    var secondaryActionBackgroundColor: UIColor { get }
    var quickActionColor: UIColor { get }
    var quickActionBackgroundColor: UIColor { get }
    var disabledActionColor: UIColor { get }
    var unselectedItemColor: UIColor { get }
    var selectedItemColor: UIColor { get }
    var disabledItemColor: UIColor { get }

    var lightBackgroundColor: UIColor { get }
    var darkBackgroundColor: UIColor { get }
    var titleFont: UIFont { get }
    var header1Font: UIFont { get }
    var header2Font: UIFont { get }
    var header3Font: UIFont { get }
    var navbarTitleFont: UIFont { get }
    var largeNavbarTitleFont: UIFont { get }

    var subtitleFont: UIFont { get }
    var property1NameFont: UIFont { get }
    var property1ValueFont: UIFont { get }
    var property2NameFont: UIFont { get }
    var property2ValueFont: UIFont { get }
    var property3NameFont: UIFont { get }
    var property3ValueFont: UIFont { get }
    var descriptionFont: UIFont { get }
    var primaryActionFont: UIFont { get }
    var secondaryActionFont: UIFont { get }
    var quickActionFont: UIFont { get }
}
