//
//  FirebaseUserObject.swift
//  TesProject
//
//  Created by Alex Balaria on 27/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import UIKit

class FirebaseUserObject {
    private var id: String
    private var email: String
    
    
    init(email: String, id: String) {
        self.email = email
        self.id = id
    }
    
    
    public func setId(id: String) -> Void {
        self.id = id
    }
    
    public func getId() -> String{
        return self.id
    }
    
    public func setEmail(email: String) -> Void {
           self.email = email
       }
       
       public func getEmail() -> String{
           return self.email
       }
    

}
