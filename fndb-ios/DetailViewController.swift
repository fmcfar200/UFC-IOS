//
//  DetailViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 19/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var costImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedSkin.name
        costLabel.text = selectedSkin.cost
        descriptionLabel.text = selectedSkin.desc
        
        downloadImage(urlstr: selectedSkin.imageLinkSmall as! String, imageView: mainImage)
        
        if (theSearchType == SearchType.BP)
        {
            let image = UIImage(named: "Battle_Pass_icon")
            costImage.image = image
            costLabel.text = ""
        }
        else{
            let image = UIImage(named: "Icon_VBucks")
            costImage.image = image
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
