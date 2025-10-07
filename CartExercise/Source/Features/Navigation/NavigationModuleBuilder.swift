//
//  NavigationModuleBuilder.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import UIKit

class NavigationModuleBuilder: PAppModuleBuilder, PHasDIContainer {
    let diContainer: PDIContainer
    let contentBuilder: (PDIContainer) -> UIViewController
    
    @Inject(.enclosingInstance)
    private var appStyle: PAppStyle
    
    init(diContainer: PDIContainer, contentBuilder: @escaping (PDIContainer) -> UIViewController) {
        self.diContainer = diContainer
        self.contentBuilder = contentBuilder
    }
    
    func build() -> UIViewController {
        let controller = UINavigationController(rootViewController: contentBuilder(diContainer))
        controller.view.backgroundColor = appStyle.darkBackgroundColor
        controller.navigationBar.backgroundColor = appStyle.darkBackgroundColor
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = appStyle.darkBackgroundColor
        let backButtonAppearance = UIBarButtonItemAppearance()
        let backImage = UIImage(systemName: "chevron.backward")?.withTintColor(appStyle.primaryColor, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: appStyle.primaryColor
        ]
        appearance.backButtonAppearance = backButtonAppearance
        appearance.titleTextAttributes = [
            .foregroundColor: appStyle.primaryColor,
            .font: appStyle.navbarTitleFont
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: appStyle.primaryColor,
            .font: appStyle.largeNavbarTitleFont
        ]
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        controller.navigationBar.isTranslucent = false
        return controller
    }
}
