//
//  SkinSelectBPViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 28/02/2019.
//  Copyright © 2019 P-Flow Studios. All rights reserved.
//

import UIKit
import GoogleMobileAds
class SkinSelectBPViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var bannerView: GADBannerView!
    var seasonNo = Int()
    var searchType = SearchType.BP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-5483417401365103/8782916306"
        
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
        case 1:
            seasonNo = tag
            searchType = SearchType.BP
        case 2:
            seasonNo = tag
            searchType = SearchType.BP
            performSegue(withIdentifier: "segue", sender: self)
        case 3:
            seasonNo = tag
            searchType = SearchType.BP
            performSegue(withIdentifier: "segue", sender: self)
        case 4:
            seasonNo = tag
            searchType = SearchType.BP
            performSegue(withIdentifier: "segue", sender: self)
        case 5:
            seasonNo = tag
            searchType = SearchType.BP
            performSegue(withIdentifier: "segue", sender: self)
        case 6:
            seasonNo = tag
            searchType = SearchType.BP
            performSegue(withIdentifier: "segue", sender: self)
        case 11:
            seasonNo = 7
            searchType = SearchType.BP
            performSegue(withIdentifier: "segue", sender: self)
        case 12:
            seasonNo = 8
            searchType = SearchType.BP
            performSegue(withIdentifier: "segue", sender: self)
        default:
            seasonNo = 1
            searchType = SearchType.BP
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
