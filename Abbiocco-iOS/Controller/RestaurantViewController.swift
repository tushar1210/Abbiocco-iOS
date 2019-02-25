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

class RestaurantViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var featureCollection: UICollectionView!
    @IBOutlet weak var reviewCollection: UICollectionView!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantTypeLabel: UILabel!
    @IBOutlet weak var restaurantTimingsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var viewFullMenuButton: UIButton!
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    var restaurantName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featureCollection.delegate = self
        featureCollection.dataSource = self
        
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
        
        print("Restaurant = ",restaurantName)
        
    } 
    
    @IBAction func featureItemButton(_ sender: Any) {
        
    }

}


extension RestaurantViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.featureCollection {
            return 6
        }else {
            return 4
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.featureCollection {
            let cell = featureCollection.dequeueReusableCell(withReuseIdentifier: "featureViewCell", for: indexPath)
            return cell
        } else {
            let cell = reviewCollection.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath)
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
