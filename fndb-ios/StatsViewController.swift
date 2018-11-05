//
//  StatsViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 31/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    struct Stat{
        var key: String!
        var value: String!
    }
    
    
    @IBOutlet weak var textEnter: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    var killsString:String = ""
    var winsString:String = ""
    var matchesString:String = ""
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var boxViews: UIView!
    
    
    var collection: [String:String] = [:]
    var statArray = [Stat]()
    
    var platform:String = "pc"
    var type:String = "p2"
    var username:String = ""
    var searched:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true

        // Do any additional setup after loading the view.
       
        
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
    
    func getStats(username:String, type:String, platform:String){
        
        statArray.removeAll()
        tableView.reloadData()
        
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
                
                let responseString = String(data: data, encoding: .utf8)
                
                do{
                    if (type != "lifeTimeStats")
                    {
                        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                        let stats = json!["stats"]! as! [String:AnyObject]
                        let soloStats = stats[type]
                        
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
                        
                        self.killsString = kills["value"] as! String
                        self.winsString = wins["value"] as! String
                        self.matchesString = matches["value"] as! String
                        
                        
                        for (key, value) in self.collection{
                            self.statArray.append(Stat(key: key, value: value as! String))
                        }
                    }
                    else{
                        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                        let stats = json![type]! as! [[String:AnyObject]]
                        for stat in stats{
                            let key = stat["key"] as? String
                            let value = stat["value"] as? String
                            self.statArray.append(Stat(key: key, value: value))
                            
                            if (key == "Wins")
                            {
                                self.winsString = value as! String
                            }
                            else if (key == "Kills")
                            {
                                self.killsString = value as! String
                            }
                            else if (key == "Matches Played")
                            {
                                self.matchesString = value as! String
                            }
                        }
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.winsLabel.text = self.winsString
                        self.killsLabel.text = self.killsString
                        self.matchesLabel.text = self.matchesString
                        
                        self.tableView.isHidden = false
                        self.boxViews.isHidden = false
                        self.searchView.isHidden = true
                        
                        self.searched = true
                    }
                    
                    
                    
                    
                    
                }
                catch let error as NSError{
                    debugPrint(error)
                }
                
                
            }
            task.resume()
        }
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
            getStats(username: username, type: type, platform: platform)

            
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
        
        username = textEnter.text!
        getStats(username: username, type: type, platform: platform)
    }
    
}
