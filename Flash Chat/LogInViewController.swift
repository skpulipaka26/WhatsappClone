//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase


class LogInViewController: UIViewController {
    
    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // login(email: "skpulipaka@gmail.com", password: "saikrishna")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        let email = emailTextfield.text
        let password = passwordTextfield.text
        
        guard email != nil, email != "", password != nil, password != "" else {
            return
        }
        login(email: email!, password: password!)
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            guard let user = authData else {
                print("login failed")
                return
            }
            print(user)
            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
    }
    
}  
