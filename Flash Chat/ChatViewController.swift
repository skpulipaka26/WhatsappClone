//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    var messagesArr: Array<Message> = Array<Message>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        messageTableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tableViewTapped)))
        configureTableView()
        
        let dbRef = Firestore.firestore().collection("messages")
        dbRef.addSnapshotListener { (snapShot, error) in
            let documentsArr = snapShot?.documents.enumerated()
            let messages = documentsArr?.map({ (_, document) -> Message in
                let message = document.data() as! Dictionary<String, String>
                return Message(message["Sender"]!, message["Message"]!)
            })
            self.messagesArr = messages ?? []
            self.configureTableView()
            self.messageTableView.reloadData()
        }
        
        messageTextfield.delegate = self
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        guard let message = messageTextfield.text, message != "" else {
            return
        }
        let data = ["Sender": Auth.auth().currentUser?.email, "Message": message]
        let uploadRef = Firestore.firestore().collection("messages").addDocument(data: data as [String : Any])
        uploadRef.addSnapshotListener { (snapShot, error) in
            guard let message = snapShot else {
                return
            }
            print(message)
            self.messageTextfield.isEnabled = true
            self.sendButton.isEnabled = true
        }
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("sign out failed")
        }
    }
    
    //MARK: -  table view delegation methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        guard !messagesArr.isEmpty else {
            return cell
        }
        
        cell.messageBody.text = messagesArr[indexPath.row].message
        cell.senderUsername.text = messagesArr[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        return cell
    }
    
    //MARK: - textfield delegate method
    
    // this is an optional method
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // this is an optional method
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK: - uitlity methods
    
    func configureTableView() {
        messageTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
}
