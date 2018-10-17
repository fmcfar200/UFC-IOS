//
//  ViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 17/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var skinButton: UIView!
    @IBOutlet weak var statsButton: UIView!
    @IBOutlet weak var weaponsButton: UIView!
    @IBOutlet weak var leaderboardButton: UIView!
    @IBOutlet weak var challengesButton: UIView!
    @IBOutlet weak var newsButton: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func skinButtonTouch(_ sender: Any)
    {
        debugPrint("SkinsTouch")
    }
    
    
}

