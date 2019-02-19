//
//  NotificationsViewController.swift
//  Abbiocco-iOS
//
//  Created by Noirdemort on 17/02/19.
//  Copyright © 2019 Noirdemort. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationCell = notificationTable.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationCell
        cell.notificationImage.image = UIImage(named: "food_and_gold")
        cell.restaurantName.text = "Tom's Diner"
        cell.notificationImage.layer.cornerRadius = 100
        cell.offerDetail.text = "50% of on order of 2000 and above."
        cell.contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        return cell
    }
    

    @IBOutlet weak var notificationTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationTable.dataSource = self
        notificationTable.delegate = self
        notificationTable.reloadData()
        notificationTable.separatorColor = UIColor.clear
        // Do any additional setup after loading the view.
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


class NotificationCell: UITableViewCell{
    
    
    @IBOutlet weak var notificationImage: UIImageView!
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var offerDetail: UITextView!
    
}
