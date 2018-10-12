//
//  Message.swift
//  Flash Chat
//
//  This is the model class that represents the blueprint for a message

class Message {
    
    var sender: String = ""
    var messageBody: String = ""
    
    init(_ _sender: String, _ _messageBody: String) {
        sender = _sender
        messageBody = _messageBody
    }
    
}
