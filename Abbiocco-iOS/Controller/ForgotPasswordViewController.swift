//
//  ForgotPasswordViewController.swift
//  Abbiocco-iOS
//
//  Created by Tushar Singh on 19/02/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

 
    @IBAction func resetButton(_ sender: Any) {
        if emailTextField.text?.isEmpty == false {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
                if error != nil{
                    print(error!)
                    self.emailTextField.text=""
                    self.emailTextField.placeholder = "* Incorrect Email"
                    self.emailTextField.placeHolderColor = .red
                }
                else{
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignIn") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
}
