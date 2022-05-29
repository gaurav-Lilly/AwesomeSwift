//
//  UserListTableViewCell.swift
//  GenericNetworkLayer
//
//  Created by GauravSharma on 04/12/19.
//  Copyright © 2019 GauravSharma. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
