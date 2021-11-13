//
//  RKBreadCrumbViewController.Models.swift
//  
//
//  Created by Reza Khonsari on 11/12/21.
//

import UIKit

extension RKBreadCrumbViewController {
    struct RKBreadCrumbCollectionModel: RKBreadCrumbCollection {
        var title: String
        var image: UIImage
        var progress: RKBreadCrumbViewCell.Progress
    }
    
}
