//
//  RKBreadCrumbViewController.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public protocol RKBreadCrumb: RKBreadCrumbContainer {
    var viewController: UIViewController { get }
}

public class RKBreadCrumbViewController: UIViewController {
    
    public typealias Model = RKBreadCrumb
    public var items = [Model]() { didSet { breadCrumbContainerView.model = items } }
    
    private var scrollView = UIScrollView()
    private var breadCrumbContainerView = RKBreadCrumbContainerView()
    private var pagerViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    public var currentIndex: Int = .zero { didSet { setIndex(currentIndex) } }
    
    private func setIndex(_ index: Int) {
        guard let index = items.indices.firstIndex(of: index) else { return }
        breadCrumbContainerView.currentIndex = index
        pagerViewController.setViewControllers([items[index].viewController], direction: .forward, animated: true)
        scrollView.scrollRectToVisible(breadCrumbContainerView.breadCrumbItemView[index].frame, animated: true)
    }

    public override func loadView() {
        super.loadView()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: Setting.breadCrumbViewHeight)
        ])
        scrollView.showsHorizontalScrollIndicator = Setting.showsHorizontalScrollIndicator
        
        scrollView.addSubview(breadCrumbContainerView)
        breadCrumbContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadCrumbContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            breadCrumbContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            breadCrumbContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            breadCrumbContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            breadCrumbContainerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        addChild(pagerViewController)
        view.addSubview(pagerViewController.view)
        pagerViewController.willMove(toParent: self)
        pagerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagerViewController.view.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            pagerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
