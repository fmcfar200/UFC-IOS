//
//  ChallengeTableViewCell.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 22/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeReward: UILabel!
    @IBOutlet weak var challengeProgress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
