//
//  SignupVC.swift
//  Abbiocco-iOS
//
//  Created by Tushar Singh on 19/02/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
   
    var model = SignupModel()
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mobileField.clearsOnBeginEditing=true
        //sleep(1)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func emailGenerate(signupModel:SignupModel){
        
        Auth.auth().createUser(withEmail: signupModel.email, password: signupModel.password) { (user, error) in
            if error != nil{
                print("\n\nERRROR",error!,"\n\n")
                
            }
            else{
                print("\n\nSuccessful Registration\n\n",signupModel)
                self.uid = (Auth.auth().currentUser?.uid)!
                self.updateDB(signupModel: signupModel,userID: self.uid)
            }
        }
    
    }
    
    func updateDB(signupModel:SignupModel!,userID:String){
        let ref = Database.database(url: "https://foodcampfinal-a121c.firebaseio.com/").reference(withPath: "users")
        let child = ref.child(userID)
      
        let userDictionary = ["id":userID,"useremail":signupModel.email,"username":signupModel.name,"usernumber":signupModel.mobile,"userpassword":signupModel.password] as [String : Any]
   
        child.setValue(userDictionary) { (error, ref) in
            if error != nil{
                print("\n\nError in updating ",error!)
            }
            else{
                print("\n\nUPDATE SUCCESSFUL")
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Landing") as UIViewController
                self.present(viewController, animated: true, completion: nil)
   
            }
        }

    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        if nameField.text?.isEmpty == false && emailField.text?.isEmpty == false && passwordField.text?.isEmpty == false && mobileField.text?.isEmpty == false{
            let range=NSRange(location: 0, length: 10)
            
            let regex = try! NSRegularExpression(pattern: "[6-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]")
         
            
            if mobileField.text?.count==10 && regex.firstMatch(in: mobileField.text!, options: [], range: range) != nil{
                model.name = nameField.text!
                model.email = emailField.text!
                model.password = passwordField.text!
                model.mobile = mobileField.text!
                print("every in place")
                emailGenerate(signupModel: model)
            }
            else{
                mobileField.text = ""
                mobileField.placeholder = " * Invalid Mobile Number "
                mobileField.placeHolderColor = .red
                
            }
        }
        
        else if nameField.text?.isEmpty == true{
            nameField.placeholder = "* This field is required"
            nameField.placeHolderColor = .red
            
        }
        else if emailField.text?.isEmpty == true{
            emailField.placeholder = "* This field is required"
            emailField.placeHolderColor = .red
            
        }
        else if mobileField.text?.isEmpty == true{
            mobileField.placeholder = "* This field is required"
            mobileField.placeHolderColor = .red
            
        }
        else if passwordField.text?.isEmpty == true{
            passwordField.placeholder = "* This field is required"
            passwordField.placeHolderColor = .red
        }
        else{
            print("Uncatched Error")
        }
        
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
}

