//
//  NavigationUtil.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/23.
//

import Foundation
import UIKit

//Pop to RootView
struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: false)
    }
static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
return nil
    }
}

/*
 Button("Pop to Root", action: {
    NavigationUtil.popToRootView()
 })
 */
