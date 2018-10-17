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
    
    let bPSkinRef = Database.database().reference().child("SPSkin")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bPSkinRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            debugPrint(snapshot.value)
            
            // ...
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
