//
//  BreadCrumbNavigationController.swift
//  
//
//  Created by Reza Khonsari on 11/13/21.
//

import UIKit

class BreadCrumbNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Uncomment here when dynamic implemented
        // interactivePopGestureRecognizer?.delegate = self
    }
}

extension BreadCrumbNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // TODO: Dynamic this method
        return false
    }
}
