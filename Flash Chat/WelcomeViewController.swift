//
//  WelcomeViewController.swift
//  Flash Chat
//
//  This is the welcome view controller - the first thign the user sees
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // testing firestore
        let firestoreRef = Firestore.firestore()
        firestoreRef.collection("users").addSnapshotListener { (documents, errors) in
            guard let snapshot = documents else {
                print("error while fetching the documents")
                return
            }
            print(snapshot.documents.first?.data() ?? "fuck you")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
