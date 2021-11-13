//
//  Setting.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public struct Setting {
    
    public init(
        spaceBetweenImageAndLabel: CGFloat = 8,
        spaceBetweenItems: CGFloat = 8,
        breadCrumbViewHeight: CGFloat = 44,
        chevronImageSize: CGFloat = 24,
        backChevronImage: UIImage = UIImage(),
        chevronImage: UIImage = UIImage(),
        imageSize: CGFloat = 16,
        showsHorizontalScrollIndicator: Bool = false,
        horizontalInset: CGFloat = 8,
        doneColor: UIColor = .green,
        todoColor: UIColor = .gray,
        inProgressColor: UIColor = .blue,
        failColor: UIColor = .red,
        warningColor: UIColor = .orange,
        returnIndexForBackButton: Int = .zero,
        animationDuration: TimeInterval = 0.3,
        borderThickness: CGFloat = 1,
        borderColor: UIColor = UIColor.lightGray,
        font: UIFont = .systemFont(ofSize: 12)
    ) {
        self.spaceBetweenImageAndLabel = spaceBetweenImageAndLabel
        self.spaceBetweenItems = spaceBetweenItems
        self.breadCrumbViewHeight = breadCrumbViewHeight
        self.chevronImageSize = chevronImageSize
        self.backChevronImage = backChevronImage
        self.chevronImage = chevronImage
        self.imageSize = imageSize
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        self.horizontalInset = horizontalInset
        self.doneColor = doneColor
        self.todoColor = todoColor
        self.inProgressColor = inProgressColor
        self.failColor = failColor
        self.warningColor = warningColor
        self.returnIndexForBackButton = returnIndexForBackButton
        self.animationDuration = animationDuration
        self.borderThickness = borderThickness
        self.borderColor = borderColor
        self.font = font
    }
    
    static let current = Setting()
    
    public var spaceBetweenImageAndLabel: CGFloat = 8
    public var spaceBetweenItems: CGFloat = 8
    public var breadCrumbViewHeight: CGFloat = 44
    public var chevronImageSize: CGFloat = 24
    // Add chevron at end of row
    public var backChevronImage: UIImage = UIImage()
    public var chevronImage: UIImage = UIImage()
    public var imageSize: CGFloat = 16
    public var showsHorizontalScrollIndicator: Bool = false
    // Space at beginning of breadcrumb and at end of breadcrumb
    public var horizontalInset: CGFloat = 8
    public var doneColor: UIColor = .green
    public var todoColor: UIColor = .gray
    public var inProgressColor: UIColor = .blue
    public var failColor: UIColor = .red
    public var warningColor: UIColor = .orange
    /// Return to presenterController
    public var returnIndexForBackButton: Int = .zero
    /// Hiding title in breadcrumb
    public var animationDuration: TimeInterval = 0.3
    public var borderThickness: CGFloat = 1
    public var borderColor: UIColor = UIColor.lightGray
    public var font: UIFont = .systemFont(ofSize: 12)
}
