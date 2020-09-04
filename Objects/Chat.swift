//
//  Chat.swift
//  TesProject
//
//  Created by Alex Balaria on 26/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import UIKit

struct Chat: Hashable {
    private var sender: String
    private var receiver: String
    private var message: String
    
    init(sender: String, receiver: String, message: String) {
        self.sender = sender
        self.receiver = receiver
        self.message = message
    }
    
    
    
        public func getSender() -> String{
            return self.sender
        }
    
       
       public func getReceiver() -> String{
           return self.receiver
       }
    
       
       public func getMessage() -> String{
           return self.message
       }

}
