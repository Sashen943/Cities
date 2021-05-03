//
//  BaseView.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import Foundation
import UIKit

protocol BaseView {
    func setTitle(_ title: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showErrorViewWithDismissAction(_ message: String)
    func showErrorViewWithRetryAction(_ message: String, _ action: Selector, _ target: Any, _ buttonTitle: String)
    func navigate(to viewController: BaseViewController)
    func addRightBarButton(_ item: UIBarButtonItem)
    func dismissKeyboard()
}
