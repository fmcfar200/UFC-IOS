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
    @IBOutlet weak var submitButton: UIButton!
    
    
    
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
        username = textEnter.text!
        checkUsername(username: username, type: type, platform: platform)
    }
    
    func checkUsername(username:String, type:String, platform:String)
    {
        let key = String("246a06d4-9ecc-443f-bd96-67e18bb94e4d")
        
        let originalURL = "https://api.fortnitetracker.com/v1/profile/"+platform+"/"+username
        let urlString = originalURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "TRN-Api-Key")
        request.httpMethod = "GET"
        
        DispatchQueue.global(qos: .userInteractive).async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    
                }
            }
        }
    }
    
}
