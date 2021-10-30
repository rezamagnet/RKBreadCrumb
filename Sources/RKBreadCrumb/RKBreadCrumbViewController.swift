//
//  RKBreadCrumbViewController.swift
//  Pagination
//
//  Created by Reza Khonsari on 9/7/21.
//

import UIKit

public protocol RKBreadCrumb: RKBreadCrumbContainer { }

public class RKBreadCrumbViewController: UIViewController {
    
    public typealias Model = RKBreadCrumb
    public var items = [Model]() { didSet { breadCrumbContainerView.model = items; view.layoutIfNeeded() } }
    
    private lazy var breadCrumbTopAnchor = scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
    
    private var scrollView = UIScrollView()
    private var breadCrumbContainerView = RKBreadCrumbContainerView()
    private var pagerViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var lineBottomView = UIView()
    public private(set) var currentIndex: Int = .zero
    
    public func setViewController(_ viewController: UIViewController, index: Int) {
        guard let index = items.indices.firstIndex(of: index) else { return }
        breadCrumbContainerView.currentIndex = index
        pagerViewController.setViewControllers([viewController], direction: .forward, animated: true)
        scrollToIndex(index)
        if navigationController?.isNavigationBarHidden == true {
            resetNavigationBarIfNeeded()
        }
    }
    
    public func scrollToIndex(_ index: Int, animated: Bool = true) {
        scrollView.scrollRectToVisible(breadCrumbContainerView.breadCrumbItemView[index].frame, animated: animated)
    }
    
    private func resetNavigationBarIfNeeded() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        breadCrumbTopAnchor.constant = .zero
    }
    
    /**
     Define this method in scrollViewDidScroll(_ scrollView: UIScrollView)
     */
    public func hideNavigationBar(onScrollView scrollView: UIScrollView) {
        if let navigationBar = navigationController?.navigationBar {
            let requiredOffset = navigationBar.frame.height + statusBarHeight
            if scrollView.contentOffset.y > requiredOffset {
                navigationController?.setNavigationBarHidden(true, animated: true)
                breadCrumbTopAnchor.constant = -(navigationBar.frame.height + statusBarHeight)
            }
            
            if scrollView.contentOffset.y < -requiredOffset {
                navigationController?.setNavigationBarHidden(false, animated: true)
                breadCrumbTopAnchor.constant = .zero
            }
        }
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
            breadCrumbTopAnchor,
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
        
        scrollView.addSubview(lineBottomView)
        lineBottomView.backgroundColor = Setting.borderColor
        lineBottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineBottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            lineBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineBottomView.heightAnchor.constraint(equalToConstant: Setting.borderThickness)
        ])
    }
}
