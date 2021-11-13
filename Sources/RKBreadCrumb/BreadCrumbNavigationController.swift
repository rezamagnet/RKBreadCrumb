//
//  BreadCrumbNavigationController.swift
//  
//
//  Created by Reza Khonsari on 11/13/21.
//

import UIKit

public class BreadCrumbNavigationController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Uncomment here when dynamic implemented
        // interactivePopGestureRecognizer?.delegate = self
    }
}

extension BreadCrumbNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // TODO: Dynamic this method
        return false
    }
}
