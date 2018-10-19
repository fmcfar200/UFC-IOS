//
//  SkinTableViewCell.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 18/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class SkinTableViewCell: UITableViewCell {

    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellCost: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var bucksImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
