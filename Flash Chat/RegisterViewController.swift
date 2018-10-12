//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
      
        let email = emailTextfield.text
        let password = passwordTextfield.text

        
        guard email != nil, email != "", password != nil, password != "" else {
            print("you tryin to act cute?")
            return
        }
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            guard let registeredUser = user else {
                print(error!)
                return
            }
            print(registeredUser)
            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
        
    }
    
    
}
