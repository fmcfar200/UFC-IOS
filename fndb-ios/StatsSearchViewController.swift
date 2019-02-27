//
//  StatsViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 31/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class StatsSearchViewController: UIViewController {
    
    
    @IBOutlet weak var textEnter: UITextField!
    var platform:String = "pc"
    var type:String = "p2"
    var username:String = ""
    var searched:Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textEnter.autocorrectionType = .no
    }
    
    
    @IBAction func typeButtonPress(_ sender: UIButton) {
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
                type = "p2"
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
                type = "p2"
            }
        }
       
        
        print (type)
    }
    @IBAction func platformButtonPress(_ sender: UIButton) {
        let tag = sender.tag
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
