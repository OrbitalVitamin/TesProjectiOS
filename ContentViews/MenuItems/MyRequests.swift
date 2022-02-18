//
//  MyRequests.swift
//  TesProject
//
//  Created by OrbitalVitamin on 24/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI

struct MyRequests: View {
    @State var users: [User] = []
    @State var showDialog: Bool
    @State var user: User
    @State var showList: Bool?
    var userType = ""

    
    var body: some View {
            GeometryReader {_ in
               ZStack{
           
                    Text("You have no requests currently").opacity(self.showList == false ? 1 : 0)

                    List (self.users){ user in
                           UserListItem(user: user).onTapGesture {
                               self.user = user
                               self.showDialog = true
                        }
                           
                       }.onAppear() {
                        UITableView.appearance().separatorStyle = .none
                        var amount = 0
                        if SingletonUserTutee.tutee.tuteeExists{
                            amount += 1
                        }
                        
                        if SingletonUserTutor.tutor.tutorExists{
                            amount += 1
                        }
                        
                        let requestCounter = RequestCounter(amount: amount)
                        
                        if SingletonUserTutee.tutee.tuteeExists{
                           Api().getData(restOfUrl: "/tutors/find_request/\((SingletonUserTutee.tutee.user?.getId())!)") { (data) in
                            self.users.append(contentsOf: self.parseJson(data: data))
                            if requestCounter.decrementTilZero(){
                                if self.users.count == 0 {
                                    self.showList = false
                                } else {
                                    self.showList = true
                                }
                            }
                           }
                        }
                        
                        if SingletonUserTutee.tutee.tuteeExists{
                            Api().getData(restOfUrl: "/tutors/find_request/\((SingletonUserTutee.tutee.user?.getId())!)") { (data) in
                                self.users.append(contentsOf: self.parseJson(data: data))
                                if requestCounter.decrementTilZero(){
                                    if self.users.count == 0 {
                                        self.showList = false
                                    } else {
                                        self.showList = true
                                    }
                                }
                            }
                        }
                    }.opacity(self.showList == true ? 1 : 0)
                }
                   
                   
                UserDialog(user: self.user, showDialog: self.$showDialog, windowType: "request", buttonText: "ACCEPT").background(Color.black.opacity(0.65)).opacity(self.showDialog == true  ? 1 : 0)
                   
               
               }
         }
    
    func parseJson(data: Data) -> [User]{
        do{
            let response = try JSONDecoder().decode(Response.self, from: data)
            let users = response.user
            print(users[0].getId())
            return users
        } catch {
            return []
        }
    }
    
}

private struct Response: Codable {
    var user: [User]
}
/*
struct MyRequests_Previews: PreviewProvider {
    static var previews: some View {
        MyRequests()
    }
} */
