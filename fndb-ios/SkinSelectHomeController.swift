//
//  SkinSelectController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 17/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit
import GoogleMobileAds

enum SearchType: String {
    case BP = "bp"
    case PROMO = "promotional"
    case SEASONAL = "holiday"
    case UNCOMMON = "uncommon"
    case RARE = "rare"
    case EPIC = "epic"
    case LEGENDARY = "legendary"
    
    init(){
        self = .BP
    }
}

class SkinSelectHomeController: UIViewController, GADInterstitialDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var seasonNo = Int()
    var searchType = SearchType.BP
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(SkinSelectHomeController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-5483417401365103/2600651331"
        
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(adRequest)
        
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5483417401365103/2345624173")
        let request = GADRequest()
        interstitial.load(request)
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        
        if (interstitial.isReady)
        {
            interstitial.present(fromRootViewController: self)

        }
        // ...
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "segue" else {return}
        let skinController = segue.destination as! SkinTableViewController
        theSearchType = searchType
        skinController.seasonNo = seasonNo
    
    }
    
    @IBAction func toSkinPress(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 2:
            searchType = SearchType.PROMO
             performSegue(withIdentifier: "segue", sender: self)
            
        case 3:
            searchType = SearchType.SEASONAL
            performSegue(withIdentifier: "segue", sender: self)
            
        default:
            searchType = SearchType.PROMO
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
