//
//  RestaurantViewController.swift
//  Abbiocco-iOS
//
//  Created by Noirdemort on 17/02/19.
//  Copyright © 2019 Noirdemort. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SwiftyJSON
import SVProgressHUD

class RestaurantViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var featureCollection: UICollectionView!
    @IBOutlet weak var reviewCollection: UICollectionView!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantTypeLabel: UILabel!
    @IBOutlet weak var restaurantTimingLabel: UILabel!
    @IBOutlet weak var restaurantAddressLAbel: UILabel!
    @IBOutlet weak var viewFullMenuButton: UIButton!
    
    var restaurantName = ""
    let ref = Database.database().reference().child("restaurants")
    var json = JSON()
    var featureImage=[String]()
    var featureName=[String]()
    var featureDescription=[String]()
    var featurePrice=[String]()
    var reviewLabel = [String]()
    var reviewImage = [String]()
    var reviewDescription = [String]()
    var reviewDict = [String:String]()
    var reviewRest = [String]()
    var stamp = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        print("HERE2")
        featureCollection.delegate = self
        featureCollection.dataSource = self
        
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
        
        print("Restaurant = ",restaurantName)
        get()
        getRecommended()
    }
    
    func get(){
        self.view.endEditing(true)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(.yellow)
        SVProgressHUD.show()
        
        ref.observe(.value) { (data) in
            self.json = JSON(data.value)
            self.assign(data: self.json)
            
        
        }
    }
    
    func getRecommended(){
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(.yellow)
        SVProgressHUD.show()
        let recref = Database.database(url: "https://foodcampfinal-582c0.firebaseio.com/").reference().child("Reviews")

        recref.observe(.value) { (snap) in
            self.assignReview(data: JSON(snap.value!))
        }
    }
    
    func assignReview(data:JSON){
        for (key,subJson):(String,JSON) in data[restaurantName]{
            stamp.append(key)
            print("Key =",key)
        }
        assignReviewval(data: data)
    }
    
    func assignReviewval(data:JSON){
        for (key):(String) in stamp{
            reviewDescription.append(data[restaurantName][key]["chats"].stringValue)
            reviewImage.append(data[restaurantName][key]["userpic"].stringValue)
            reviewLabel.append(data[restaurantName][key]["username"].stringValue)
            print("VAL==",data[restaurantName][key]["userpic"].stringValue,key)
        }
        
        reload()
        
    }
    
    
    func assign(data:JSON){
//MARK: - Main
        restaurantNameLabel.text = restaurantName
        restaurantTypeLabel.text = data[restaurantName]["description"].stringValue
    
        restaurantImage.sd_setImage(with: URL(string: data[restaurantName]["imagemain"].stringValue)!) { (image, e, cache, url) in
            if e != nil{
                print("ERROR in RESTMAIN")
            }
        }
        restaurantTimingLabel.text = data[restaurantName]["time"].stringValue
        restaurantAddressLAbel.text = data[restaurantName]["add"].stringValue

//MARK:- featureCollection
        for (key,subJson):(String,JSON) in data[restaurantName]["feature"]{
            
            featureName.append(JSON(subJson["editname"]).stringValue)
            print("KEY==",featureName)
        }
        for i in 1...featureName.count-1{
            print("fNAME",featureName[i])
            featureImage.append(data[restaurantName]["feature"][i]["editimage"].stringValue)
            featurePrice.append(data[restaurantName]["feature"][i]["editprice"].stringValue)
            featureDescription.append(data[restaurantName]["feature"][i]["editfood"].stringValue)
        }
        
    }
    func reload(){
        featureCollection.reloadData()
        reviewCollection.reloadData()
        SVProgressHUD.dismiss()
        self.view.endEditing(false)
    }
    
    @IBAction func featureItemButton(_ sender: Any) {
        print("clicked")
    }
    

    @IBAction func viewFullMenu(_ sender: Any) {
        
        
    }
    
    @IBAction func viewAllbutton(_ sender: Any) {
        
        
    }
    
}


extension RestaurantViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.featureCollection {
            return featureName.count-1
        }else {
            return reviewDescription.count
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.featureCollection {
            let cell = featureCollection.dequeueReusableCell(withReuseIdentifier: "featureViewCell", for: indexPath) as! FeatureViewCell
            cell.featuredItemName.text = featureName[indexPath.row+1]
            cell.featureImage.sd_setImage(with: URL(string: featureImage[indexPath.row])) { (image, e, cache, url) in
                    if e != nil{
                        print("ERROR IN FEATURE",e!)
                    }
                }
            cell.featuredItemDescription.text = featureDescription[indexPath.row]
            cell.featuredItemPriceButton.isEnabled=false
            cell.featuredItemPriceButton.setTitle(featurePrice[indexPath.row], for: .normal)
            cell.featuredItemPriceButton.isEnabled = true
            return cell
            
        }
        else {
            
            let cell = reviewCollection.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
            cell.reviewDescription.text = reviewDescription[indexPath.row]
            cell.reviewLabel.text = reviewLabel[indexPath.row]
            
            
            
            
            return cell
        }
    }
    
}




class FeatureViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var featureImage: UIImageView!
    @IBOutlet weak var featuredItemName: UILabel!
    @IBOutlet weak var featuredItemDescription: UITextView!
    @IBOutlet weak var featuredItemPriceButton: UIButton!

}


class ReviewCell: UICollectionViewCell{
    
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewDescription: UITextView!
    
}
