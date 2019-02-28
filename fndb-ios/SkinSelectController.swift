//
//  SkinSelectController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 17/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

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

class SkinSelectController: UIViewController {
    
    
    
    var seasonNo = Int()
    var searchType = SearchType.BP
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
