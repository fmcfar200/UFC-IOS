//
//  ChallengeViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 22/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

struct ChallengeResponse: Decodable {
    let language:String?
    let season: Int?
    let currentweek: Int?
    let star:String?
    let challenges:[metadata]?
}

struct metadata: Decodable{
    let week:Int?
    let value:String?
    let entries:[Challenge]?
    
}
struct challengeKV: Decodable
{
    let key:String?
    let value: String?
}

class ChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var challengeCollection = [Challenge]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let key = String("a4587bc8429ba5f7e2be4d869fddf5ff")
        let url = URL(string: "https://fortnite-public-api.theapinetwork.com/prod09/challenges/get?season=current")!
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
                    let challengeResponse = try JSONDecoder().decode(ChallengeResponse.self, from: data)
                    //self.challengeCollection = challengeResponse.challenges
                    let currentWeek = challengeResponse.currentweek!
                    let c = challengeResponse.challenges!
                    for metadata in c{
                        if (currentWeek == metadata.week)
                        {
                            let entries = metadata.entries!
                            self.challengeCollection = entries
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
                }catch let jsonErr{
                    print(jsonErr)
                }
                
                
            }
            task.resume()
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ChallengeCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ChallengeTableViewCell else{
            fatalError("cell error: not member of ChallengeTableViewCell")
        }
        
        let challenge = self.challengeCollection[indexPath.row]
        cell.challengeTitle.text = challenge.challenge
        cell.challengeProgress.text = "0/" + String(challenge.total!)
        cell.challengeReward.text  = String(challenge.stars!)
        
        cell.layoutSubviews()
        return cell
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
