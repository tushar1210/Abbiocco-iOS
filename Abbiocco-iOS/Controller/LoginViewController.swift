//
//  LoginViewController.swift
//  Abbiocco-iOS
//
//  Created by Tushar Singh on 19/02/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTeextField: UITextField!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func auth(email:String,pass:String){
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if error != nil{
                print("\n\nERROR in SIGN IN ", error!)
            }
            else{
                print("\n\nSuccess LOGIN", result!)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Landing") as UIViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        if emailTextField.text?.isEmpty == false && passwordTeextField.text?.isEmpty == false {
            auth(email: emailTextField.text!, pass: passwordTeextField.text!)
        }
        else if (emailTextField.text?.isEmpty)!{
            emailTextField.text = ""
            emailTextField.placeholder = "*This Field is Mandatory"
            emailTextField.placeHolderColor = .red
            
        }
        else{
            passwordTeextField.text = ""
            passwordTeextField.placeholder = "*This Field is Mandatory"
            passwordTeextField.placeHolderColor = .red
        }
        
    }
    
}
