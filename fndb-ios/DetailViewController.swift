//
//  DetailViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 19/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit
import GoogleMobileAds

class DetailViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var costImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(adRequest)
        
        
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
