//
//  CityTableViewCell.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    // MARK: Attribute(s)
    
    static let identifier = "city"
    
    // MARK: IBOutlet(s)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Action(s)
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Method(s)
    
    func configureCell(title: String, subtitle: String) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
    }

}
