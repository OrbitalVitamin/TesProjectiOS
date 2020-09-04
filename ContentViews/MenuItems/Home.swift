//
//  Home.swift
//  TesProject
//
//  Created by Alex Balaria on 24/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var tabIndex: Int
    
    static let ecp_blue = Color("ecp_blue")
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    self.tabIndex = 1
                }) {
                    Text("TutorMatches").foregroundColor(Color.white).padding()
                }
                Spacer()
                Spacer()
                
                Button(action: {
                    self.tabIndex = 2
                }) {
                    Text("TuteeMatches").foregroundColor(Color.white).padding()
                }
                
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading).background(Home.ecp_blue)
            
            ZStack{
                TutorMatches(users: [], showDialog: false, user: User(id: 0, email: "", name: "", description: "", year: 0, subjects: [])).opacity(self.tabIndex == 1 ? 1 : 0)
                TuteeMatches(users: [], showDialog: false, user: User(id: 0, email: "", name: "", description: "", year: 0, subjects: [])).opacity(self.tabIndex == 2 ? 1 : 0)
            }
            Spacer()
        }
    }
}

struct TutorMatches: View {

    @State var users: [User] = []
    @State var showDialog: Bool
    @State var user: User
    
    var body: some View{
        ZStack{
            List (users){ user in
                UserListItem(user: user).onTapGesture {
                    self.user = user
                    self.showDialog = true
                }
                
            }.onAppear() {
                UITableView.appearance().separatorStyle = .none
                Api().getData(restOfUrl: "/tutors/find_matches/2") { (data) in
                self.users = self.parseJson(data: data)
                }
            }
            
                GeometryReader {_ in
                    UserDialog(user: self.user, showDialog: self.$showDialog, windowType: "home", buttonText: "Send Request")
                }.background(Color.black.opacity(0.65)).opacity(self.showDialog == true  ? 1 : 0)
            
        
        }.edgesIgnoringSafeArea(.horizontal)
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

struct TuteeMatches: View {
    @State var users: [User] = []
    @State var showDialog: Bool
    @State var user: User
    var body: some View{
        ZStack{
            List (users){ user in
                UserListItem(user: user).onTapGesture {
                    self.user = user
                    self.showDialog = true
                }
                
            }.onAppear() {
                UITableView.appearance().separatorStyle = .none
                Api().getData(restOfUrl: "/tutees/find_matches/2") { (data) in
                    self.users = self.parseJson(data: data)
                }
            }
            
                GeometryReader {_ in
                    UserDialog(user: self.user, showDialog: self.$showDialog, windowType: "home", buttonText: "Send Request")
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(tabIndex: 1)
    }
}
