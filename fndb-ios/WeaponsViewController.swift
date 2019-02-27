//
//  WeaponsViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 23/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit

struct WeaponsResponse:Decodable{
    let rarity:String?
    let css:String?
    let rows:Int?
    let weapons:[Weapon]?
}

class WeaponsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
   
    var weaponCollection = [Weapon]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Do any additional setup after loading the view.
        
        let key = String("a4587bc8429ba5f7e2be4d869fddf5ff")
        let url = URL(string: "https://fortnite-public-api.theapinetwork.com/prod09/weapons/get")!
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
                
                let responseString = String(data: data, encoding: .utf8)
                //print("responseString = \(String(describing: responseString))")
                do {
                    let weaponResponse = try JSONDecoder().decode(WeaponsResponse.self, from: data)
                    self.weaponCollection = weaponResponse.weapons!
                    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weaponCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "WeaponCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? WeaponCollectionViewCell else{
            fatalError("cell error: not member of [CELL]")
        }
        
        downloadImage(urlstr: (self.weaponCollection[indexPath.row].images?.background)!, imageView: cell.cellImage)
        
        cell.layoutSubviews()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let weapon = self.weaponCollection[indexPath.row]
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weaponPopUpController") as! PopUpViewController
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: self)
        
        popUpVC.nameLabel.text = weapon.name
        popUpVC.rarityLabel.text = weapon.rarity
        downloadImage(urlstr: (weapon.images?.background)!, imageView: popUpVC.weaponImage)
        
        let damageString1 = "Body: " + (weapon.stats?.damage?.body)!
        let damageString2 = "Head: " + (weapon.stats?.damage?.head)!
        
        let damage = theStat(name: "Damage", value: damageString1 + " " + damageString2)
        let dps = theStat(name:"DPS", value: weapon.stats!.dps)
        let fireRate = theStat(name:"Fire Rate", value: weapon.stats!.firerate)
        let reloadTime = theStat(name:"Reload Time", value: weapon.stats!.magazine?.reload)
        let magSize = theStat(name:"Magazine Size", value: weapon.stats!.magazine?.size)
        let ammoCost = theStat(name:"Ammo Cost", value: weapon.stats!.ammocost)
        
        popUpVC.statCollection.removeAll()
        
            popUpVC.statCollection.append(damage)
            popUpVC.statCollection.append(dps)
            popUpVC.statCollection.append(fireRate)
            popUpVC.statCollection.append(reloadTime)
            popUpVC.statCollection.append(magSize)
            popUpVC.statCollection.append(ammoCost)
            popUpVC.tableView.reloadData()
        
        
       
        
        
        
        
        
        
        
        
        
        
        
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
