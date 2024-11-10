//
//  UITabBarController+Extension.swift
//  trip-companions
//
//  Created by 영현 on 10/4/24.
//

import Foundation
import UIKit
import SwiftUI

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tabBar.layer.masksToBounds = true
//        tabBar.layer.cornerRadius = 16
        // Choose with corners should be rounded
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // top left, top right

        // Uses `accessibilityIdentifier` in order to retrieve shadow view if already added
        if let shadowView = view.subviews.first(where: { $0.accessibilityIdentifier == "TabBarShadow" }) {
            shadowView.frame = tabBar.frame
        } else {
            let shadowView = UIView(frame: .zero)
            shadowView.frame = tabBar.frame
            shadowView.accessibilityIdentifier = "TabBarShadow"
            shadowView.backgroundColor = UIColor.white
            shadowView.layer.cornerRadius = tabBar.layer.cornerRadius
            shadowView.layer.maskedCorners = tabBar.layer.maskedCorners
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowColor = Color.gray.opacity(0.1).cgColor
            shadowView.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
            shadowView.layer.shadowOpacity = 0.1
            shadowView.layer.shadowRadius = 10
            view.addSubview(shadowView)
            view.bringSubviewToFront(tabBar)
        }
    }
}
