//
//  NewsViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 19/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var newsCollection = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsCollection.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "NewsTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NewsTableViewCell else{
            fatalError("cell error: not member of NewsTableViewCell")
        }
        
        
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
