//
//  LoadingIndicator.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import UIKit

class LoadingIndicator: UIView {
    
    // MARK: IBOutlet(s)
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var contentView: UIView!
    
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
        Bundle.main.loadNibNamed("LoadingIndicator",
                                 owner: self,
                                 options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func startLoadingIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    public func stopLoadingIndicator() {
        self.activityIndicator.stopAnimating()
    }
}
