//
//  SkinTableViewController.swift
//  fndb-ios
//
//  Created by fraser mcfarlane on 18/10/2018.
//  Copyright © 2018 P-Flow Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleMobileAds

var theSearchType = SearchType.EPIC
var selectedSkin = Skin()


class SkinTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var tableView: UITableView!
    
    var skinCollection = [Skin]()
    
    var seasonNo = Int()
    
    let bPSkinRef = Database.database().reference().child("SPSkin")
    let iSSkinRef = Database.database().reference().child("ISSkin")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adRequest = GADRequest()
        bannerView.adUnitID = "ca-app-pub-5483417401365103/5613951192"
        
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(adRequest)
        
        
        print(seasonNo, theSearchType)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var dataRef = DatabaseReference()
        if (theSearchType == SearchType.BP)
        {
            dataRef = bPSkinRef.child("SP_S" + String(seasonNo) + "_Skins")
        }
        else
        {
            dataRef = iSSkinRef.child(theSearchType.rawValue + "_Skins")
        }
        
        // Do any additional setup after loading the view.
        dataRef.observe(.value, with: { (snapshot) in
            var theCollection = [Skin]()
            for item in snapshot.children.allObjects as! [DataSnapshot]
            {
                let SkinObject = item.value as? [String: AnyObject]
                let id = SkinObject?["id"]
                let name = SkinObject?["name"]
                let rarity = SkinObject?["rarity"]
                let desc = SkinObject?["dsc"]
                let imageLinkSmall = SkinObject?["imageLinkSmall"]
                
                let theSkin = Skin(id: id as! String, name: name as! String, rarity: rarity as! String, desc: desc as! String, imageLinkSmall: imageLinkSmall as! String)
                theCollection.append(theSkin)
            }
            
            self.skinCollection = theCollection
            self.tableView.reloadData()
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        
    }

    // MARK: - Table view data source


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return skinCollection.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SkinTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier , for: indexPath) as? SkinTableViewCell else{
         
            fatalError("cell error .not member of SkinTableViewCell")
        
        }

        // Configure the cell...
        let skin = self.skinCollection[indexPath.row]
        cell.cellName.text = skin.name
        
        let imageURL = URL(string: skin.imageLinkSmall as! String)
        downloadImage(urlstr: skin.imageLinkSmall as! String, imageView: cell.cellImage)
        
        if (theSearchType == SearchType.BP)
        {
            cell.cellCost.text = ""
            let image = UIImage(named: "Battle_Pass_icon")
            cell.bucksImage.image = image
        }
        else{
            cell.cellCost.text = skin.cost
            let image = UIImage(named: "Icon_VBucks")
            cell.bucksImage.image = image
        }
        
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedSkin = self.skinCollection[indexPath.row]
        performSegue(withIdentifier: "segueDetail", sender: self)
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

func downloadImage(urlstr: String, imageView: UIImageView) {
    let url = URL(string: urlstr)!
    let task = URLSession.shared.dataTask(with: url) { data, _, _ in
        guard let data = data else { return }
        DispatchQueue.main.async { // Make sure you're on the main thread here
            imageView.image = UIImage(data: data)
        }
    }
    task.resume()
}
