//
//  MyMatches.swift
//  TesProject
//
//  Created by OrbitalVitamin on 24/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI

struct MyMatches: View {
    @State var users: [User] = []
        @State var showDialog: Bool
        @State var user: User
        @State var showList: Bool?

        
        var body: some View {
                GeometryReader {_ in
                   ZStack{
               
                        Text("You have no matches currently").opacity(self.showList == false ? 1 : 0)

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
                            
                            if SingletonUserTutor.tutor.tutorExists{
                                print(" The User Tutee ID \(SingletonUserTutor.tutor.user?.getId())")
                               Api().getData(restOfUrl: "/tutees/find_matched/\((SingletonUserTutor.tutor.user?.getId())!)") { (data) in
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
                                Api().getData(restOfUrl: "/tutors/find_matched/\((SingletonUserTutor.tutor.user?.getId())!)") { (data) in
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
                       
                       GeometryReader {_ in
                        UserDialog(user: self.user, showDialog: self.$showDialog, userType: "tutees", windowType: "Matches", buttonText: "Open Chat")
                       }.background(Color.black.opacity(0.65)).opacity(self.showDialog == true  ? 1 : 0)
                   
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
struct MyMatches_Previews: PreviewProvider {
    static var previews: some View {
        MyMatches()
    }
} */
