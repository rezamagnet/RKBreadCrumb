//
//  Setting.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public enum Setting {
    public static var spaceBetweenImageAndLabel: CGFloat = 8
    public static var spaceBetweenItems: CGFloat = 8
    public static var breadCrumbViewHeight: CGFloat = 44
    public static var chevronImageSize: CGFloat = 24
    // Add chevron at end of row
    public static var chevronImage: UIImage = UIImage()
    public static var imageSize: CGFloat = 16
    public static var showsHorizontalScrollIndicator: Bool = false
    // Space at beginning of breadcrumb and at end of breadcrumb
    public static var horizontalInset: CGFloat = 8
    public static var doneColor: UIColor = .green
    public static var todoColor: UIColor = .gray
    public static var inProgressColor: UIColor = .blue
    /// Hiding title in breadcrumb
    public static var animationDuration: TimeInterval = 0.3
    public static var borderThickness: CGFloat = 1
    public static var borderColor: UIColor = UIColor.lightGray
    public static var font: UIFont = .systemFont(ofSize: 12)
}
