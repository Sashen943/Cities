//
//  BaseViewController.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Attribute(s)
    
    private let errorView = ErrorView()
    private let loadingIndicatorView = LoadingIndicator()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Method(s)
    
    private func addSubViewAndBringToFront(view: UIView) {
        if let navigationController = self.navigationController,
           let frame = self.navigationController?.view.frame {
            navigationController.view.addSubview(view)
            view.frame = frame
            navigationController.view.bringSubviewToFront(view)
        } else {
            self.view.addSubview(view)
            view.frame = self.view.frame
            self.view.bringSubviewToFront(view)
        }
    }
    
    private func addSubViewAndBlockScreen(view: UIView) {
        if let navigationController = self.navigationController {
            navigationController.view.addSubview(view)
            view.frame = self.view.frame
            navigationController.view.bringSubviewToFront(view)
        } else {
            self.view.addSubview(view)
            view.frame = self.view.frame
            self.view.bringSubviewToFront(view)
        }
    }
    
}

// MARK: BaseView Extension

extension BaseViewController: BaseView {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func navigate(to viewController: BaseViewController) {
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showLoadingIndicator() {
        self.addSubViewAndBringToFront(view: loadingIndicatorView)
        self.loadingIndicatorView.startLoadingIndicator()
    }
    
    func hideLoadingIndicator() {
        self.loadingIndicatorView.removeFromSuperview()
        self.loadingIndicatorView.stopLoadingIndicator()
    }
    
    func showErrorViewWithDismissAction(_ message: String) {
        self.errorView.showErrorWithDismissAction(message)
        self.addSubViewAndBlockScreen(view: errorView)
    }
    
    func showErrorViewWithRetryAction(_ message: String, _ action: Selector, _ target: Any, _ buttonTitle: String) {
        self.errorView.showErrorWithRetryAction(message, target: target, action: action)
        self.addSubViewAndBlockScreen(view: errorView)
    }
    
    func addRightBarButton(_ item: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = item
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}

