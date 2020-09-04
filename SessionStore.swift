//
//  SessionStore.swift
//  TesProject
//
//  Created by Alex Balaria on 29/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import Foundation
import Firebase

class SessionStore: ObservableObject {
    @Published public var isLoggedIn = ""
    var email: String = ""
    var name: String = ""
    
    func listen() {
        _ = Auth.auth().addStateDidChangeListener{(auth, user) in
            if let user = user {
                self.checkIfUserExists(name: user.displayName!, email: user.email!)
            } else {
                self.isLoggedIn = ""
            }
            
            
        }
    }
    
    func checkIfUserExists(name: String, email: String){
    let requestCounter = RequestCounter.init(amount: 2)
    print(email)
    
    
    Api().getData(restOfUrl: "/tutees/find_user/" + email) { (data) in
        let user = self.parseJson(data: data)
        if user.getId() != 0 {
            SingletonUserTutee.tutee.user = user
            SingletonUserTutee.tutee.tuteeExists = true
        } else {
            print("user is nil")
        }
        if requestCounter.decrementTilZero() {
            if(SingletonUserTutor.tutor.tutorExists || SingletonUserTutee.tutee.tuteeExists){
                self.isLoggedIn = "Main"
            } else {
                self.isLoggedIn = "Register"
            }
        }
    }
    
    Api().getData(restOfUrl: "/tutors/find_user/" + email) { (data) in
        let user = self.parseJson(data: data)
        if user.getId() != 0 {
            print(user.getDescription())
            SingletonUserTutor.tutor.user = user
            SingletonUserTutor.tutor.tutorExists = true
            print(SingletonUserTutor.tutor.user!.getName())
        } else {
            print("user is nil")
        }
        
        if requestCounter.decrementTilZero() {
            if(SingletonUserTutor.tutor.tutorExists || SingletonUserTutee.tutee.tuteeExists){
                self.isLoggedIn = "Main"
            }else {
                self.isLoggedIn = "Register"
            }
        }
        
    }
        
    }
    func parseJson(data: Data) -> User{
        var user: User?
        var response: Response?
        do {
            response = try JSONDecoder().decode(Response.self, from: data)
            user = response!.user
            return user!
        } catch {
            print("error caught")
            return User(id: 0, email: "", name: "", description: "", year: 0, subjects: [""])
        }
        
        
    }
    
 
    
    private class Response: Codable {
        var user: User
    }
}
