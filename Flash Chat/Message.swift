//
//  Message.swift
//  Flash Chat
//
//  This is the model class that represents the blueprint for a message

class Message {
    
    var sender: String = ""
    var message: String = ""
    
    init(_ _sender: String, _ _message: String) {
        sender = _sender
        message = _message
    }
    
}
