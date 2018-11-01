//
//  StatsViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 31/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    struct statsResponse: Decodable{
        let accountId:String?
        let platformId:Int?
        let platformName:String?
        let platformNameLong:String?
        let epicUserHandle:String?
        let stats:PlayerStats?
        
    }
    
    
    
    
    @IBOutlet weak var textEnter: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        let key = String("246a06d4-9ecc-443f-bd96-67e18bb94e4d")
        let url = URL(string: "https://api.fortnitetracker.com/v1/profile/pc/ninja")!
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "TRN-Api-Key")
        request.httpMethod = "GET"
        var theCollection:PlayerStats!
        
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
                
                let responseString = String(data: data, encoding: .utf8)
                
                do{
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                    let stats = json!["stats"]! as! [String:AnyObject]
                    let soloStats = stats["p2"]
                    let count = Int(soloStats!.count)-1
                    
                    var collection: [String:Any] = [:]
                    let wins = soloStats!["top1"] as! [String:AnyObject]
                    let kills = soloStats!["kills"] as! [String:AnyObject]
                    let matches = soloStats!["matches"] as! [String:AnyObject]
                    
                    collection.updateValue(wins, forKey: "Wins")
                    
                    
                    
                    
                    
                    
                    
                }
                catch let error as NSError{
                    debugPrint(error)
                }
                

            }
            task.resume()
        }
        
    }
    
}
