//
//  Setting.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

enum Setting {
    static var spaceBetweenImageAndLabel: CGFloat = 8
    static var spaceBetweenItems: CGFloat = 8
    static var breadCrumbViewHeight: CGFloat = 44
    static var chevronImageSize: CGFloat = 24
    // Add chevron at end of row
    static var chevronImage: UIImage = UIImage()
    static var imageSize: CGFloat = 16
    static var showsHorizontalScrollIndicator: Bool = true
    // Space at beginning of breadcrumb and at end of breadcrumb
    static var horizontalInset: CGFloat = 8
    static var doneColor: UIColor = .green
    static var todoColor: UIColor = .gray
    static var inProgressColor: UIColor = .blue
    /// Hiding title in breadcrumb
    static var animationDuration: TimeInterval = 0.3
}
