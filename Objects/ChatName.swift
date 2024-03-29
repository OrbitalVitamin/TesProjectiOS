//
//  File.swift
//  TesProject
//
//  Created by OrbitalVitamin on 30/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import UIKit
struct ChatName: Codable {
    private var username: String
    private var chatName: String
    
    init(username: String, chatName: String){
        self.username =  username
        self.chatName = chatName
    }
    
      public func getUsername() -> String{
          return self.username
      }
      
        public func getChatName() -> String{
           return self.chatName
       }
}
