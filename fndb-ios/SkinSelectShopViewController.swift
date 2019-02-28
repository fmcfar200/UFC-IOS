//
//  SkinSelectShopViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 28/02/2019.
//  Copyright © 2019 P-Flow Studios. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SkinSelectShopViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var bannerView: GADBannerView!
    var seasonNo = Int()
    var searchType = SearchType.BP
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(adRequest)
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "segue" else {return}
        let skinController = segue.destination as! SkinTableViewController
        theSearchType = searchType
        skinController.seasonNo = seasonNo
        
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 7:
            seasonNo = 0
            searchType = SearchType.UNCOMMON
        case 8:
            seasonNo = 0
            searchType = SearchType.RARE
        case 9:
            seasonNo = 0
            searchType = SearchType.EPIC
        case 10:
            seasonNo = 0
            searchType = SearchType.LEGENDARY
            
        default:
            seasonNo = 0
            searchType = SearchType.UNCOMMON
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
