//
//  StatTableViewCell.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 27/02/2019.
//  Copyright © 2019 P-Flow Studios. All rights reserved.
//

import UIKit

class WeaponStatTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
