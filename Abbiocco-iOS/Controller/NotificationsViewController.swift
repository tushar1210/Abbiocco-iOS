//
//  NotificationsViewController.swift
//  Abbiocco-iOS
//
//  Created by Tushar Singh on 22/02/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import SVProgressHUD
import SDWebImage

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notificationTable: UITableView!
    
    let ref = Database.database().reference().child("notification")
    var json:JSON?
    var nameArray:[String]=[]
    var notifyArray:[String]=[]
    var imageArray:[URL]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(.yellow)
        SVProgressHUD.show()
        notificationTable.dataSource = self
        notificationTable.delegate = self
//        notificationTable.reloadData()
        notificationTable.separatorColor = UIColor.clear
        
    }
    
    func get(){
        ref.observe(DataEventType.value, with: { (data) in
            self.json = JSON(data.value)
            for i in 2...self.json!.count-1{
                if let name = self.json![Int(i)]["name"].string{
                    self.nameArray.append(name)
                }
                if let image = self.json![Int(i)]["image"].string{
                    self.imageArray.append(URL(string: image)!)
                }
                if let notify = self.json![Int(i)]["notify"].string{
                    self.notifyArray.append(notify)
                }
            }
            
            self.notificationTable.reloadData()
            SVProgressHUD.dismiss()
        })
    }
    




}


class NotificationCell: UITableViewCell{
    
    
    @IBOutlet weak var notificationImage: UIImageView!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var offerDetail: UITextView!
    
}

extension NotificationsViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationCell = notificationTable.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationCell
        cell.notificationImage.sd_setImage(with: imageArray[indexPath.row]) { (image, e, cache, url) in
            if e != nil{
                print("EROR in IMAGE",e)
            }
        }
        cell.restaurantName.text = nameArray[indexPath.row]
        cell.notificationImage.layer.cornerRadius = 100
        cell.offerDetail.text = notifyArray[indexPath.row]
        cell.contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        return cell
    }
    
}
