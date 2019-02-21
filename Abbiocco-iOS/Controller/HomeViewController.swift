//
//  HomeViewController.swift
//  Abbiocco-iOS
//
//  Created by Tushar Singh on 20/02/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import SVProgressHUD
import SDWebImage

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var foodTypeCollection: UICollectionView!
    @IBOutlet weak var restaurantCollection: UICollectionView!
    @IBOutlet weak var recommendedCollection: UICollectionView!
    @IBOutlet weak var cuisineCollection: UICollectionView!
    @IBOutlet weak var popularCollection: UICollectionView!
    @IBOutlet weak var newItemsCollection: UICollectionView!
    @IBOutlet weak var trendingCollection: UICollectionView!
    
    var modelObject = RestaurantModel()
    var json:JSON=[]
    let ref = Database.database().reference()
    var dataRecieved = false
    var restaurantNameArray:[String] = []
    var restaurantDescriptionArray:[String] = []
    var i=0
    var foodTypeArray:[String] = []
    var restaurantImageURLArray:[URL] = []
    var restaurantRatingArray:[String] = []
    var restaurantTimingArray:[String] = []

    var recommendNameArray:[String]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        foodTypeCollection.dataSource = self
        foodTypeCollection.delegate = self
        
        restaurantCollection.delegate = self
        restaurantCollection.dataSource = self
        
        recommendedCollection.delegate = self
        recommendedCollection.dataSource = self
        
        cuisineCollection.delegate = self
        cuisineCollection.dataSource = self
        
        popularCollection.delegate = self
        popularCollection.dataSource = self
        
        newItemsCollection.delegate = self
        newItemsCollection.dataSource = self
        
        trendingCollection.delegate = self
        trendingCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func get(){
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(.yellow)
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        self.ref.observe(.value) { (data) in
            
            print("DATA Recieved")
            
            self.dataRecieved = true
            self.assgin(data: JSON(data.value))
            
        }
    }
    
    
    func assgin(data:JSON){
        json = data
        for (key,subJson):(String,JSON) in json["restaurants"]{
            modelObject.name = key
            restaurantNameArray.append(modelObject.name!)
            restaurantDescriptionArray.append(json["restaurants"][key]["description"].stringValue)
            restaurantImageURLArray.append(URL(string: json["restaurants"][key]["image"].stringValue)!)
            restaurantRatingArray.append(json["restaurants"][key]["rate"].stringValue)
            restaurantTimingArray.append(json["restaurants"][key]["time"].stringValue)
        }
        

        for (key,subJson):(String,JSON) in json["Food"]{
            var keyInt = Int(key)!
            foodTypeArray.append(json["Food"][keyInt]["cuisinetype"].stringValue)
        }
        
        
        for (key,subJson):(String,JSON) in json["Recommended"]{
            recommendNameArray.append(key)
        }
        
        foodTypeCollection.reloadData()
        restaurantCollection.reloadData()
        recommendedCollection.reloadData()
        cuisineCollection.reloadData()
        popularCollection.reloadData()
        newItemsCollection.reloadData()
        trendingCollection.reloadData()
        SVProgressHUD.dismiss()
        self.view.isUserInteractionEnabled = true
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let style:UIStatusBarStyle = .lightContent
        return style
    }
    

    

}


class FoodTypeCell: UICollectionViewCell{
    
    @IBOutlet weak var foodImage: RoundImage!
    
    @IBOutlet weak var foodName: UILabel!
}


class RestaurantCell: UICollectionViewCell{
    
    @IBOutlet weak var hotelImage: UIImageView!
    
    @IBOutlet weak var hotelName: UILabel!
    
    @IBOutlet weak var hotelType: UILabel!
    
    @IBOutlet weak var hotelSchedule: UILabel!
    
    @IBOutlet weak var hotelRating: UILabel!
}



class RecommendedCell: UICollectionViewCell{
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var hotelName: UILabel!

    @IBOutlet weak var hotelSchedule: UILabel!
}


class CuisineTypeCell: UICollectionViewCell{
    
    @IBOutlet weak var foodImage: RoundImage!
    
    @IBOutlet weak var foodName: UILabel!
    
}

class PopularCell: UICollectionViewCell{
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var hotelName: UILabel!
    
    
}


class NewItemCell: UICollectionViewCell{
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var hotelName: UILabel!
    
    @IBOutlet weak var foodDescription: UITextView!
    
    
}

class TrendingCell: UICollectionViewCell{
    
    
    @IBOutlet weak var hotelName: UILabel!
    
    
    @IBOutlet weak var foodImage: UIImageView!
}

//MARK: - UIelements
extension HomeViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView==self.restaurantCollection{
            return restaurantNameArray.count
        }
        if collectionView==self.foodTypeCollection{
            return foodTypeArray.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodTypeCollection {
            let cell: FoodTypeCell = foodTypeCollection.dequeueReusableCell(withReuseIdentifier: "foodTypeCell", for: indexPath) as! FoodTypeCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.foodImage.layer.cornerRadius = cell.foodImage.frame.size.width/2
            cell.foodName.text = foodTypeArray[indexPath.row]
            return cell
        }
        else if (collectionView == self.restaurantCollection){
            
            let cell: RestaurantCell = restaurantCollection.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
            cell.hotelImage.sd_setImage(with: restaurantImageURLArray[indexPath.row]) { (image, e, cacheType, url) in
                
            }
            cell.hotelName.text = restaurantNameArray[indexPath.row]
            cell.hotelType.text = restaurantDescriptionArray[indexPath.row]
            cell.hotelRating.text = restaurantRatingArray[indexPath.row]
            cell.hotelSchedule.text = restaurantTimingArray[indexPath.row]
            return cell
        }
        else if collectionView == self.recommendedCollection {
            let cell: RecommendedCell = recommendedCollection.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            cell.hotelSchedule.text = "10:00am - 9:00pm"
            return cell
        }
        else if ( collectionView == self.cuisineCollection ){
            let cell: CuisineTypeCell = cuisineCollection.dequeueReusableCell(withReuseIdentifier: "cuisineTypeCell", for: indexPath) as! CuisineTypeCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.foodImage.layer.cornerRadius = cell.foodImage.frame.size.width/2
            
            cell.foodName.text = "Food name"
            return cell
        }
        else if collectionView == self.popularCollection {
            let cell: PopularCell = popularCollection.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PopularCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            cell.foodName.text = "Veg Noodles"
            return cell
        }
        else if collectionView == self.newItemsCollection {
            let cell: NewItemCell = newItemsCollection.dequeueReusableCell(withReuseIdentifier: "newItemCell", for: indexPath) as! NewItemCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            cell.foodDescription.text = "A mood changing ambiance with a variety of mouthwatering options to choose them."
            return cell
        }
        else {
            let cell: TrendingCell = trendingCollection.dequeueReusableCell(withReuseIdentifier: "trendingCell", for: indexPath) as! TrendingCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            return cell
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
