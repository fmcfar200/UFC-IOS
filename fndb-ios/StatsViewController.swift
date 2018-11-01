//
//  StatsViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 31/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    
    struct statsResponse: Decodable{
        let accountId:String?
        let platformId:Int?
        let platformName:String?
        let platformNameLong:String?
        let epicUserHandle:String?
        let stats:PlayerStats?
        
    }
    
    struct Stat{
        var key: String!
        var value: String!
    }
    
    
    
    
    @IBOutlet weak var textEnter: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var collection: [String:String] = [:]
    var statArray = [Stat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

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
                    
                    let wins = soloStats!["top1"] as! [String:AnyObject]
                    let kills = soloStats!["kills"] as! [String:AnyObject]
                    let matches = soloStats!["matches"] as! [String:AnyObject]
                    let winRatio = soloStats!["winRatio"] as! [String:AnyObject]
                    let kd = soloStats!["kd"] as! [String:AnyObject]
                    let kpg = soloStats!["kpg"] as! [String:AnyObject]
                    let scorePerMatch = soloStats!["scorePerMatch"] as! [String:AnyObject]
                    let score = soloStats!["score"] as! [String:AnyObject]





                    
                    self.collection.updateValue(wins["value"] as! String, forKey: wins["label"] as! String)
                    self.collection.updateValue(kills["value"] as! String, forKey: kills["label"] as! String)
                    self.collection.updateValue(matches["value"] as! String, forKey: matches["label"] as! String)
                    self.collection.updateValue(winRatio["value"] as! String, forKey: winRatio["label"] as! String)
                    self.collection.updateValue(kd["value"] as! String, forKey: kd["label"] as! String)
                    self.collection.updateValue(kpg["value"] as! String, forKey: kpg["label"] as! String)
                    self.collection.updateValue(scorePerMatch["value"] as! String, forKey: scorePerMatch["label"] as! String)
                    self.collection.updateValue(score["value"] as! String, forKey: score["label"] as! String)

                    
                    for (key, value) in self.collection{
                        self.statArray.append(Stat(key: key, value: value as! String))
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
                    
                    
                    
                }
                catch let error as NSError{
                    debugPrint(error)
                }
                

            }
            task.resume()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "StatsCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? StatsTableViewCell else{
            fatalError("cell error: not member of [CELL]")
        }
        
        let item = statArray[indexPath.row]
        cell.keyLabel.text = item.key
        cell.valueLabel.text = item.value
        cell.layoutSubviews()
        return cell
    }
    
}
