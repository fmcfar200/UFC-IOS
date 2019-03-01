//
//  ViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 17/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, GADBannerViewDelegate {
    
    
    
    struct itemShopResponse:Decodable {
        let date_layout:String?
        let lastupdate:Int?
        let date:String?
        let rows:Int?
        let vbucks:String?
        let items:[ShopItem]?
    
    }

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var skinButton: UIView!
    @IBOutlet weak var statsButton: UIView!
    @IBOutlet weak var weaponsButton: UIView!
    @IBOutlet weak var leaderboardButton: UIView!
    @IBOutlet weak var challengesButton: UIView!
    @IBOutlet weak var newsButton: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchType = SearchType.PROMO
    
    var shopCollection = [ShopItem]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-5483417401365103/2721615429"
        
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(adRequest)
        
        collectionView.dataSource=self
        collectionView.delegate=self
        
        
        let key = String("a4587bc8429ba5f7e2be4d869fddf5ff")
        let url = URL(string: "https://fortnite-public-api.theapinetwork.com/prod09/store/get")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(key, forHTTPHeaderField: "Authorization")
        
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
                    let shopResponse = try JSONDecoder().decode(itemShopResponse.self, from: data)
                    self.shopCollection = shopResponse.items!
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                    
                }catch let jsonErr{
                    print(jsonErr)
                }
                
                
            }
            task.resume()
        }

    }
    
    @IBAction func skinButtonTouch(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "segueHome")
        {
            let skinController = segue.destination as! SkinTableViewController
            theSearchType = self.searchType
            skinController.seasonNo = 0
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "ShopCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ShopCollectionViewCell else{
            fatalError("cell error: not member of ShopCollectionViewCell")
        }
        
        let item = self.shopCollection[indexPath.row]
        cell.nameLabel.text = item.name
        cell.priceLabel.text = item.cost
        downloadImage(urlstr: (item.item?.images?.background)!, imageView: cell.imageView)
        cell.nameLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        
        cell.layoutSubviews()
        return cell
    }
    
    
}

