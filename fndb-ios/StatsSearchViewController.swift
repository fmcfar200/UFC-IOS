//
//  StatsViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 31/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit
import GoogleMobileAds

class StatsSearchViewController: UIViewController, GADBannerViewDelegate {
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var textEnter: UITextField!
    
    var platform:String = "pc"
    var type:String = "lifeTimeStats"
    var username:String = ""
    var searched:Bool = false
    
    
    @IBOutlet weak var lifetimeButton: UIButton!
    @IBOutlet weak var dueButton: UIButton!
    @IBOutlet weak var squadButton: UIButton!
    @IBOutlet weak var soloButton: UIButton!
    @IBOutlet weak var pcButton: UIButton!
    @IBOutlet weak var xboxButton: UIButton!
    @IBOutlet weak var psnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lifetimeButton.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
        pcButton.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
        


        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-5483417401365103/8336317450"
        
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(adRequest)
        
        
        textEnter.autocorrectionType = .no
        textEnter.returnKeyType = .done
    }
    
    func unselectButtonsTypes()
    {
        lifetimeButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        soloButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        dueButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        squadButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        
        
    }
    func unselectButtonsPlat()
    {
        pcButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        xboxButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        psnButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        
        
    }
    
    
    @IBAction func typeButtonPress(_ sender: UIButton) {
        self.unselectButtonsTypes()
        sender.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
        let tag = sender.tag
        if (!searched)
        {
            switch tag {
            case 0:
                type = "lifeTimeStats"
            case 1:
                type = "p2"
            case 2:
                type = "p10"
            case 3:
                type = "p9"
            default:
                type = "lifeTimeStats"
            }
        }
        else{
            switch tag {
            case 0:
                type = "lifeTimeStats"
            case 1:
                type = "p2"
            case 2:
                type = "p10"
            case 3:
                type = "p9"
            default:
                type = "lifeTimeStats"
            }
        }
       
        
        print (type)
    }
    @IBAction func platformButtonPress(_ sender: UIButton) {
        let tag = sender.tag
        unselectButtonsPlat()
        sender.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
        switch tag {
        case 0:
            platform = "pc"
        case 1:
            platform = "xbox"
        case 2:
            platform = "psn"
        default:
            platform = "pc"
        }
        
        print(platform)
    }
    
    @IBAction func submiteButtonPress(_ sender: UIButton) {
        view.endEditing(true)
        //performSegue(withIdentifier: "segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segue" else {return}
        let statsController = segue.destination as! StatsListViewController
        statsController.theType = type
        statsController.thePlatform = platform
        statsController.theUsername = textEnter.text!
        
        
    }
    
    
    
    
}
