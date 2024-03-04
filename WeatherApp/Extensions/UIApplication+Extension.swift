///

import UIKit
extension UIApplication {

    /**
     */
    var rootNavigationController: UINavigationController? {
        return windows.first?.rootViewController as? UINavigationController
    }

    /**
     */
    func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if Thread.isMainThread == false {
            assertionFailure()
        }

        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            if let nav = presented as? UINavigationController {
                return topViewController(base: nav)
            }
            return topViewController(base: presented)
        }
        return base
    }
}
