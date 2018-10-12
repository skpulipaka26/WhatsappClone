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
//        let firestoreRef = Firestore.firestore()
//        firestoreRef.collection("users").addSnapshotListener { (documents, errors) in
//            guard let snapshot = documents else {
//                print("error while fetching the documents")
//                return
//            }
//            let allUsers = snapshot.documents.enumerated()
//            let up = allUsers.map({ (offset, documentSnapshot) -> [String: String] in
//                var data = documentSnapshot.data()
//                let id = documentSnapshot.documentID
//                data["id"] =  id
//                return data as! [String: String]
//            })
//            print(up)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
