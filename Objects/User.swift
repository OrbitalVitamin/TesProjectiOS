//
//  User.swift
//  TesProject
//
//  Created by Alex Balaria on 26/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import UIKit

struct User : Codable, Identifiable{
    internal var id: Int
    private var email: String
    private var name: String
    private var description: String
    private var year: Int
    private var subjects: [String]
    
    init(id: Int, email: String, name: String, description: String, year: Int, subjects: [String]) {
        self.id = id
        self.email = email
        self.name = name
        self.description = description
        self.year = year
        self.subjects = subjects
    }
    
 
    
    public func getId() -> Int{
        return self.id
    }
    
   
    
    public func getEmail() -> String{
        return self.email
    }
    
  
     
     public func getName() -> String{
         return self.name
     }
    
    public func getDescription() -> String{
        return self.description
    }
    
    public func getYear() -> Int{
        return self.year
    }

    
    public func getSubjects() -> [String]{
        return self.subjects
    }

    
    
}
