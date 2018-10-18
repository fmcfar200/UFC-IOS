//
//  SkinViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 17/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SkinViewController: UIViewController {
    
    var skinCollection = [Skin]()
    let bPSkinRef = Database.database().reference().child("SPSkin")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var s1Skin = bPSkinRef.child("SP_S1_Skins")
        // Do any additional setup after loading the view.
        s1Skin.observe(.value, with: { (snapshot) in
            
            for item in snapshot.children.allObjects as! [DataSnapshot]
            {
                let SkinObject = item.value as? [String: AnyObject]
                let id = SkinObject?["id"]
                let name = SkinObject?["name"]
                let rarity = SkinObject?["rarity"]
                let desc = SkinObject?["dsc"]
                let imageLinkSmall = SkinObject?["imageLinkSmall"]

                let theSkin = Skin(id: id as! String, name: name as! String, rarity: rarity as! String, desc: desc as! String, imageLinkSmall: imageLinkSmall as! String)
                self.skinCollection.append(theSkin)
            }
            
        }) { (error) in
            print(error.localizedDescription)
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
