//
//  MockUINavigationController.swift
//  WinePairTestsModule
//
//  Created by Matheus Góes on 05/10/22.
//

import UIKit
@testable import WinePair

final class MockUINavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    var poppedViewController: UIViewController?
    var viewControllerPresented: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        poppedViewController = pushedViewController
        return super.popViewController(animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerPresented = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
