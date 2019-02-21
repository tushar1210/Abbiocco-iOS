//
//  HomeViewController.swift
//  Abbiocco-iOS
//
//  Created by Tushar Singh on 20/02/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

//Restaurant Cell competed
//food Type completed (zero issue to be resolved in backend)
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

    @IBOutlet weak var editorImView: UIImageView!
    @IBOutlet weak var editorRestNameLabel: UILabel!
    @IBOutlet weak var editorTimingLabel: UILabel!
    @IBOutlet weak var editorRatingLabel: UILabel!
    
    var modelObject = RestaurantModel()
    var json:JSON=[]
    let ref = Database.database().reference()
    var dataRecieved = false
    var restaurantNameArray:[String] = []
    var restaurantDescriptionArray:[String] = []
    var foodTypeArray:[String] = []
    var foodTypeImageURL:[URL]=[]
    var restaurantImageURLArray:[URL] = []
    var restaurantRatingArray:[String] = []
    var restaurantTimingArray:[String] = []
    var recommendNameArray:[String]=[]
    var recommendImageURL:[URL]=[]
    var recommendTimimg:[String]=[]
    var cuisineArray:[String]=[]
    var cuisineImageURL:[URL]=[]
    var popularName:[String]=[]
    var popularImageURL:[URL]=[]
    var popularFood:[String]=[]
    var trendingName:[String]=[]
    var trendingImageURL:[URL]=[]
    var whatsNewName:[String]=[]
    var whatsNewDesc:[String]=[]
    var whatsNewImgURL:[URL]=[]
    var dict:[String:String]=["k":"c","a":"q"]
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
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
    
    func getJSON(){
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(.yellow)
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ref.observe(DataEventType.value, with: { (data) in
            print("DATA Recieved")
            self.dataRecieved = true
            self.assgin(data: JSON(data.value))
        })
    }
    
    
    func assgin(data:JSON){
        json = data
        
        //MARK: - restaurants
        var k=0
        for (key,subJson):(String,JSON) in json["restaurants"]{
            modelObject.name = key
            restaurantNameArray.append(modelObject.name!)
            restaurantDescriptionArray.append(json["restaurants"][key]["description"].stringValue)
            restaurantImageURLArray.append(URL(string: json["restaurants"][key]["image"].stringValue)!)
            restaurantRatingArray.append(json["restaurants"][key]["rate"].stringValue)
            restaurantTimingArray.append(json["restaurants"][key]["time"].stringValue)
            popularName.append(json["restaurants"][key]["popname"].stringValue)
            popularFood.append(json["restaurants"][key]["popfood"].stringValue)
            popularImageURL.append(URL(string: json["restaurants"][key]["popimage"].stringValue)!)
            print("name=  ",restaurantNameArray[k])
            k+=1
            
        }
        
//MARK: - CUISINE
        for (key,subJson):(String,JSON) in json["Food"]{
            var keyInt = Int(key)!
            foodTypeArray.append(json["Food"][keyInt]["cuisinetype"].stringValue)
            if let url = json["Food"][keyInt]["cuisineimage"].string{
                foodTypeImageURL.append(URL(string: url)!)
            }
            
        }
//MARK: - Recommended
        for (key,subJson):(String,JSON) in json["Recommended"]{
            recommendNameArray.append(key)
            recommendTimimg.append(json["Recommended"][key]["editname"].stringValue)
            if let url = json["Recommended"][key]["editimage"].string{
                recommendImageURL.append(URL(string: url)!)
            }
        }
//MARK: - Cuisine
        for (key,subJson):(String,JSON) in json["Cuisine"]{
            cuisineArray.append(key)
            if let url = json["Cuisine"][key]["cuisineimage"].string{
                cuisineImageURL.append(URL(string: url)!)
            }
        }
//MARK: - EDITOR
        for (key,subJson):(String,JSON) in json["editors"]{
            editorRestNameLabel.text = key
            print("URL ",json["editors"][key]["editimage"].stringValue)
            editorImView.sd_setImage(with: URL(string: json["editors"][key]["editimage"].stringValue)) { (image, e, cache, url) in
                if e != nil{
                    print("ERROR IN EDITOR",e)
                }
            }
            editorTimingLabel.text = json["editors"][key]["editname"].stringValue
            editorRatingLabel.text = json["editors"][key]["editprice"].stringValue
        }
        
//MARK: - TRENDING
        for (key,subJson):(String,JSON) in json["trending"]{
            trendingName.append(key)
            trendingImageURL.append(URL(string: json["trending"][key]["popimage"].stringValue)!)
        }
//MARK: - WHATSNEW
        for (key,subJson):(String,JSON) in json["WhatsNew"]{
            whatsNewName.append(key)
            whatsNewDesc.append(json["WhatsNew"][key]["editfood"].stringValue)
            whatsNewImgURL.append(URL(string: json["WhatsNew"][key]["editimage"].stringValue)!)
        }
        
        reloadAll()
    }
    
    func reloadAll(){
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
//PRAGMA: - reomve -1
        
        if collectionView==self.foodTypeCollection{
            return foodTypeArray.count-1 //Remove -1 when 0 is fixed
        }
        if collectionView==self.recommendedCollection{
            return recommendNameArray.count
        }
        if collectionView==self.cuisineCollection{
            return cuisineArray.count
        }
//        if collectionView==self.{
//            return cuisineArray.count
//        }
        if collectionView==popularCollection{
            return popularName.count
        }
        if collectionView==trendingCollection{
            return trendingName.count
        }
        if collectionView==newItemsCollection{
            return whatsNewName.count
        }
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodTypeCollection {
            let cell: FoodTypeCell = foodTypeCollection.dequeueReusableCell(withReuseIdentifier: "foodTypeCell", for: indexPath) as! FoodTypeCell
            cell.foodImage.sd_setImage(with: foodTypeImageURL[indexPath.row]) { (image, e, cache, url) in
                if e != nil{
                    print("ERROR in FOOD TYPE IMAGE", e)
                }

            }
            cell.foodImage.layer.cornerRadius = cell.foodImage.frame.size.width/2
            cell.foodName.text = foodTypeArray[indexPath.row]
            return cell
        }
        else if (collectionView == self.restaurantCollection){
            
            let cell: RestaurantCell = restaurantCollection.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
            cell.hotelImage.sd_setImage(with: restaurantImageURLArray[indexPath.row]) { (image, e, cacheType, url) in
                if e != nil{
                    print("ERROR in FOOD TYPE IMAGE", e)
                }
            }
            cell.hotelName.text = restaurantNameArray[indexPath.row]
            cell.hotelType.text = restaurantDescriptionArray[indexPath.row]
            cell.hotelRating.text = restaurantRatingArray[indexPath.row]
            cell.hotelSchedule.text = restaurantTimingArray[indexPath.row]
            return cell
        }
        else if collectionView == self.recommendedCollection {
            let cell: RecommendedCell = recommendedCollection.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedCell
           
            cell.foodImage.sd_setImage(with: recommendImageURL[indexPath.row]) { (image, e, cache, url) in
                if e != nil{
                    print("ERROR IN RECOMMEND",e)
                    }
                }
            cell.hotelName.text = recommendNameArray[indexPath.row]
            
            cell.hotelSchedule.text = recommendTimimg[indexPath.row]
            return cell
        }
        else if ( collectionView == self.cuisineCollection ){
            let cell: CuisineTypeCell = cuisineCollection.dequeueReusableCell(withReuseIdentifier: "cuisineTypeCell", for: indexPath) as! CuisineTypeCell
            cell.foodImage.sd_setImage(with: cuisineImageURL[indexPath.row]) { (image, e, cache, url) in
                if e != nil{
                    print("ERROR IN CUISINE",e)
                }
            }
            cell.foodImage.layer.cornerRadius = cell.foodImage.frame.size.width/2
            
            cell.foodName.text = cuisineArray[indexPath.row]
            return cell
        }
        else if collectionView == self.popularCollection {
            let cell: PopularCell = popularCollection.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PopularCell
            cell.foodImage.sd_setImage(with: popularImageURL[indexPath.row]) { (image, e, cache, url) in
                if e != nil{
                    print("ERROR IN Popular",e)
                }
            }
            cell.hotelName.text = popularName[indexPath.row]
            cell.foodName.text = popularFood[indexPath.row]
            return cell
        }
        else if collectionView == self.newItemsCollection {
            let cell: NewItemCell = newItemsCollection.dequeueReusableCell(withReuseIdentifier: "newItemCell", for: indexPath) as! NewItemCell
            cell.foodImage.sd_setImage(with: whatsNewImgURL[indexPath.row]) { (image, e, cache, url) in
                if e != nil{
                    print("ERROR IN WhatsNew",e)
                }
            }
            cell.hotelName.text = whatsNewName[indexPath.row]
            cell.foodDescription.text = whatsNewDesc[indexPath.row]
            return cell
        }
        else {
            let cell: TrendingCell = trendingCollection.dequeueReusableCell(withReuseIdentifier: "trendingCell", for: indexPath) as! TrendingCell
            cell.foodImage.sd_setImage(with: trendingImageURL[indexPath.row]) { (image, e, cache, url) in
                if e != nil{
                    print("ERROR IN TRENDING",e)
                }
            }
            cell.hotelName.text = trendingName[indexPath.row]
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
