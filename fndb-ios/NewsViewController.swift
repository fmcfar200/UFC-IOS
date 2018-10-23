//
//  NewsViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 19/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

struct NewsResponse: Decodable{
    let type: String?
    let typesm: String?
    let entries: [News]
}

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var newsCollection = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let key = String("a4587bc8429ba5f7e2be4d869fddf5ff")
        let url = URL(string: "https://fortnite-public-api.theapinetwork.com/prod09/br_motd/get")!
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
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
                
                //let responseString = String(data: data, encoding: .utf8)
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    self.newsCollection = newsResponse.entries
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
        // #warning Incomplete implementation, return the number of rows
        return newsCollection.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "newsCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NewsTableViewCell else{
            fatalError("cell error: not member of NewsTableViewCell")
        }
        
        let news = self.newsCollection[indexPath.row]
        cell.newsTitle.text = news.title
        cell.newsBody.text = news.body
        cell.newsBody.sizeToFit()
        downloadImage(urlstr: news.image!, imageView: cell.newsImage!)
        
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
