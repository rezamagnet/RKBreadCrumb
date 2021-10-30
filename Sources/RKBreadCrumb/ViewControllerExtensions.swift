//
//  ViewControllerExtensions.swift
//  
//
//  Created by Reza on 8/8/1400 AP.
//

import UIKit

public extension UIViewController {
    var breadCrumbViewController: RKBreadCrumbViewController? {
        if let controller = parent as? RKBreadCrumbViewController {
            return controller
        } else if let controller = parent?.parent as? RKBreadCrumbViewController{
            return controller
        } else {
            return nil
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
