//
//  LeaderboardViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 24/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate, GADInterstitialDelegate {
    
    
    struct LeaderboardResponse: Decodable {
        let window:String?
        let entries:[Leaderboard]
    }
    

    
    
    var leaderboardCollectionKills = [Leaderboard]()
    var leaderboardCollectionWins = [Leaderboard]()
    var leaderboardCollectionMins = [Leaderboard]()
    var theLBCollection = [Leaderboard]()
    
    let killsSearch = "kills"
    let winsSearch = "wins"
    let scoreSearch = "score"
    let minsSearch = "minutes"
    var theSearch:String = ""
    
    var selectedUsername = ""
    var selectedPlatform = ""
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(LeaderboardViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-5483417401365103/4780215825"
        
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(adRequest)
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5483417401365103/5901725806")
        let request = GADRequest()
        interstitial.load(request)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getTop10(type: killsSearch)

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTouch(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:
            print("Kills")
            getTop10(type: killsSearch)
            theSearch = killsSearch
            tableView.reloadData()
            headerLabel.text = "Kills"
        case 1:
            print("Wins")
            getTop10(type: winsSearch)
            theSearch = winsSearch
            tableView.reloadData()
            headerLabel.text = "Wins"

        case 2:
            print("Score")
            getTop10(type: scoreSearch)
            theSearch = scoreSearch
            tableView.reloadData()
            headerLabel.text = "Score"

        case 3:
            print("Mins")
            getTop10(type: minsSearch)
            theSearch = minsSearch
            tableView.reloadData()
            headerLabel.text = "Minutes"

        default:
            print("Kills")
            getTop10(type: killsSearch)
            tableView.reloadData()
            headerLabel.text = "Kills"

        }
        
    }
    
    func getTop10(type:String){
        startIndicator(indicator: activityIndicator)
        let key = String("a4587bc8429ba5f7e2be4d869fddf5ff")
        let url = URL(string: "https://fortnite-public-api.theapinetwork.com/prod09/leaderboards/get?window=top_10_"+type)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.setValue("v1.1", forHTTPHeaderField: "X-Fortnite-API-Version")
        request.setValue("application/form-data current", forHTTPHeaderField: "season")
        
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
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                do {
                    let leaderboardResponse = try JSONDecoder().decode(LeaderboardResponse.self, from: data)
                    let entries = leaderboardResponse.entries
                    self.theLBCollection = entries
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.endIndicator(indicator: self.activityIndicator)
                    }
                    
                    
                }catch let jsonErr{
                    print(jsonErr)
                }
                
                
            }
            task.resume()
        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theLBCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "LeaderboardCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? LeaderboardTableViewCell else{
            fatalError("cell error: not member of LeaderboardTableViewCell")
        }
        
        let item = theLBCollection[indexPath.row]
        cell.nameLabel.text = item.username
        
        if (theSearch == killsSearch)
        {
            cell.valueLabel.text = item.kills

        }
        else if (theSearch == winsSearch)
        {
            cell.valueLabel.text = item.wins
        }
        else if (theSearch == scoreSearch)
        {
            cell.valueLabel.text = item.score
        }
        else{
            cell.valueLabel.text = item.minutes

        }
        
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (theLBCollection[indexPath.row].username != nil)
        {
            selectedUsername = theLBCollection[indexPath.row].username!
            selectedPlatform = theLBCollection[indexPath.row].platform!
            
            if(selectedPlatform == "xb1")
            {
                selectedPlatform = "xbox"
            }
            performSegue(withIdentifier: "segue", sender: self)

        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segue" else {return}
        let statsController = segue.destination as! StatsListViewController
        statsController.thePlatform = selectedPlatform
        statsController.theUsername = selectedUsername
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        
        if (interstitial.isReady)
        {
            interstitial.present(fromRootViewController: self)
            
        }
        // ...
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
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
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    
    func endIndicator(indicator: UIActivityIndicatorView)
    {
        indicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }

}
