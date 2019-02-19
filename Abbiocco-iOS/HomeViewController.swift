//
//  HomeViewController.swift
//  Abbiocco-iOS
//
//  Created by Noirdemort on 18/02/19.
//  Copyright © 2019 Noirdemort. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodTypeCollection {
        let cell: FoodTypeCell = foodTypeCollection.dequeueReusableCell(withReuseIdentifier: "foodTypeCell", for: indexPath) as! FoodTypeCell
        cell.foodImage.image = UIImage(named: "food_and_gold")
        cell.foodImage.layer.cornerRadius = cell.foodImage.frame.size.width/2
        
        cell.foodName.text = "Food name"
        return cell
        } else if (collectionView == self.restaurantCollection){
            let cell: RestaurantCell = restaurantCollection.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
            cell.hotelImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            cell.hotelType.text = "American (Traditional), Continental"
            cell.hotelRating.text = "4.5"
            cell.hotelSchedule.text = "10:00am - 9:00pm"
            return cell
        } else if collectionView == self.recommendedCollection {
            let cell: RecommendedCell = recommendedCollection.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            cell.hotelSchedule.text = "10:00am - 9:00pm"
            return cell
        } else if ( collectionView == self.cuisineCollection ){
            let cell: CuisineTypeCell = cuisineCollection.dequeueReusableCell(withReuseIdentifier: "cuisineTypeCell", for: indexPath) as! CuisineTypeCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.foodImage.layer.cornerRadius = cell.foodImage.frame.size.width/2
            
            cell.foodName.text = "Food name"
            return cell
        } else if collectionView == self.popularCollection {
            let cell: PopularCell = popularCollection.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as! PopularCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            cell.foodName.text = "Veg Noodles"
            return cell
        } else if collectionView == self.newItemsCollection {
            let cell: NewItemCell = newItemsCollection.dequeueReusableCell(withReuseIdentifier: "newItemCell", for: indexPath) as! NewItemCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            cell.foodDescription.text = "A mood changing ambiance with a variety of mouthwatering options to choose them."
            return cell
        } else {
            let cell: TrendingCell = trendingCollection.dequeueReusableCell(withReuseIdentifier: "trendingCell", for: indexPath) as! TrendingCell
            cell.foodImage.image = UIImage(named: "food_and_gold")
            cell.hotelName.text = "Tom's Diner"
            return cell
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    var style:UIStatusBarStyle = .lightContent
    
    
    @IBOutlet weak var foodTypeCollection: UICollectionView!
    
    
    @IBOutlet weak var restaurantCollection: UICollectionView!
    
    
    @IBOutlet weak var recommendedCollection: UICollectionView!
    
    
    @IBOutlet weak var cuisineCollection: UICollectionView!
    
    
    @IBOutlet weak var popularCollection: UICollectionView!
    
    @IBOutlet weak var newItemsCollection: UICollectionView!
    
    
    @IBOutlet weak var trendingCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
