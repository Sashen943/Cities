//
//  ErrorView.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import UIKit

import UIKit

class ErrorView: UIView {
    
    // MARK: Localised string(s)
    
    private let dismissLabel = "dismiss"
    private let retryLabel = "retry"
    
    // MARK: IBOutlet(s)
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorActionButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: Constructor(s)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialiseView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialiseView()
    }
    
    // MARK: Method(s)
    
    private func initialiseView() {
        Bundle.main.loadNibNamed("ErrorView",
                                 owner: self,
                                 options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    public func showErrorWithDismissAction(_ errorMessage: String) {
        self.errorLabel.text = errorMessage
        self.errorActionButton.setTitle(dismissLabel, for: .normal)
        self.errorActionButton.setTitle(dismissLabel, for: .normal)
        self.addDismissAction()
    }
    
    public func showErrorWithRetryAction(_ errorMessage: String,
                                         target: Any,
                                         action: Selector) {
        self.errorLabel.text = errorMessage
        self.errorActionButton.setTitle(retryLabel, for: .normal)
        self.addDismissAction()
        self.errorActionButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    @objc func addDismissAction() {
        self.errorActionButton.addTarget(self,
                                         action: #selector(self.dismissAction),
                                         for: .touchUpInside)
    }
    
    @objc func dismissAction() {
        self.removeFromSuperview()
    }
    
}
