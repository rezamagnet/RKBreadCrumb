//
//  ViewControllerExtensions.swift
//  
//
//  Created by Reza on 8/8/1400 AP.
//

import UIKit

public extension UIViewController {
    
    func getBreadCrumbViewController(_ parent: UIViewController? = nil) -> RKBreadCrumbViewController {
        if let parent = parent as? RKBreadCrumbViewController {
            return parent
        } else {
            if let parent = parent {
                return getBreadCrumbViewController(parent.parent)
            } else {
                return getBreadCrumbViewController(self.parent)
            }
        }
    }
    
    
    var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
