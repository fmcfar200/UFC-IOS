//
//  StatsListViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 27/02/2019.
//  Copyright © 2019 P-Flow Studios. All rights reserved.
//

import UIKit
import GoogleMobileAds

class StatsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GADBannerViewDelegate {

    struct Stat{
        var key: String!
        var value: String!
    }
    
    var statArray = [Stat]()
    
    @IBOutlet weak var lifeTimeButton: UIButton!
    @IBOutlet weak var soloButton: UIButton!
    @IBOutlet weak var duoButton: UIButton!
    @IBOutlet weak var squadButton: UIButton!
    

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var matchesLabel: UILabel!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    var killsString:String = ""
    var winsString:String = ""
    var matchesString:String = ""
    
    var collection: [String:String] = [:]
    
    
    var thePlatform:String = "pc"
    var theType:String = "lifeTimeStats"
    var theUsername:String = ""
    var searched:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-5483417401365103/8144745763"
        
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(adRequest)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        getStats(username: theUsername, type: theType, platform: thePlatform)
        
        switch theType {
        case "lifeTimeStats":
            lifeTimeButton.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
        case "p2":
            soloButton.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
        case "p10":
            duoButton.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
        case "p9":
            squadButton.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
            
        default:
            lifeTimeButton.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
        }

        self.navigationItem.title = theUsername
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
        
        startIndicator(indicator: activityIndicator)
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
                        if (json!["error"] != nil)
                        {
                            print("error")
                            self.showalertNotFound(title: "Player Not Found", message: "Unable to find username. Make sure you have entered the correct username and platform.")
                            return
                        }
                        
                        if (json!["stats"] == nil)
                        {
                            print("error")
                            self.showalertReset(title: "Stats Not Found", message: "These statistics are unavailable for this player.")
                            return
                        }
                        let stats = json!["stats"]! as! [String:AnyObject]
                        
                        let soloStats = stats[type]
                        if (soloStats == nil)
                        {
                            print("error")
                            self.showalertReset(title: "Stats Not Found", message: "These statistics are unavailable for this player.")
                            return
                        }
                        
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
                        if (json!["error"] != nil)
                        {
                            print("error")
                            self.showalertNotFound(title: "Player Not Found", message: "Unable to find username. Make sure you have entered the correct username and platform.")
                            return
                            
                        }
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
                        
                        self.endIndicator(indicator: self.activityIndicator)

                        
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
        unselectButtonsTypes()
        sender.backgroundColor = UIColor(red:0.00, green:0.41, blue:0.75, alpha:1.0)
            switch tag {
            case 0:
                theType = "lifeTimeStats"
            case 1:
                theType = "p2"
            case 2:
                theType = "p10"
            case 3:
                theType = "p9"
            default:
                theType = "lifeTimeStats"
            }
            getStats(username: theUsername, type: theType, platform: thePlatform)
            
            
        }
    
    func unselectButtonsTypes()
    {
        lifeTimeButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        soloButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        duoButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        squadButton.backgroundColor = UIColor( red:0.49, green:0.59, blue:0.74, alpha:1.0)
        
        
    }
    
    func showalertNotFound(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert,animated: true, completion: nil)
    }
    func showalertReset(title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            
            alert.dismiss(animated: true
                , completion: {
                    self.getStats(username: self.theUsername, type: "lifeTimeStats", platform: self.thePlatform)
            })
        }))
        self.present(alert,animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func startIndicator(indicator: UIActivityIndicatorView)
    {
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(indicator)
        
        indicator.startAnimating()
        
    }
    
    func endIndicator(indicator: UIActivityIndicatorView)
    {
        indicator.stopAnimating()
    }
}

