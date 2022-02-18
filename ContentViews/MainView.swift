//
//  ContentView.swift
//  TesProject
//
//  Created by OrbitalVitamin on 24/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State private var isShowing = false
    @State var showMenu = false
    @State var viewType = "Home"
    static let ecp_blue = Color("ecp_blue")
    
    init() {
        // this is not the same as manipulating the proxy directly
        let appearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        appearance.configureWithTransparentBackground()
        
        // this only applies to big titles
        appearance.largeTitleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        // this only applies to small titles
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        //In the following two lines you make sure that you apply the style for good
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        // This property is not present on the UINavigationBarAppearance
        // object for some reason and you have to leave it til the end
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backgroundColor = .init(red: 0.140625, green: 0.140625, blue: 0.359375, alpha: 1)
        
    }

    var body: some View {
        
        let drag = DragGesture().onEnded{
            if $0.translation.width < -100 {
                             withAnimation {
                                 self.showMenu = false
                             }
            }
        }
        
    

        return NavigationView {
            
            GeometryReader { geometry in
                ZStack(alignment: .leading){
                    MenuStackView(viewType: self.$viewType).frame(width: geometry.size.width, height: geometry.size.height)
                    .disabled(self.showMenu ? true : false)
                    if self.showMenu{
                        MenuView(viewType: self.$viewType).frame(width: geometry.size.width/1.7).transition(.move(edge: .leading))
                    }
                }.gesture(drag)
                
                }.navigationBarTitle(Text(self.viewType).foregroundColor(Color.white), displayMode: .inline)
                    .navigationBarItems(leading: (Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
        
        
    }
    
}


struct MenuStackView: View {
    @Binding var viewType : String
    var body: some View {
        /*GeometryReader { geometry in
        ZStack{
            
            Home(tabIndex: 1).opacity(self.viewType == "Home" ? 1 : 0)
            Profile().opacity(self.viewType == "Profile" ? 1 : 0)
            MyMatches(showDialog: false, user: User(id: 0, email: "", name: "", description: "", year: 0, subjects: [] )).opacity(self.viewType == "Matches" ? 1 : 0)
            ChatRoom().opacity(self.viewType == "ChatRoom" ? 1 : 0)
            MyRequests(showDialog: false, user: User(id: 0, email: "", name: "", description: "", year: 0, subjects: [] )).opacity(self.viewType == "Requests" ? 1 : 0)
            }
            } */
        ZStack {
            if self.viewType == "Home" {
                Home(tabIndex: 1)
            } else if self.viewType == "Matches" {
                 MyMatches(showDialog: false, user: User(id: 0, email: "", name: "", description: "", year: 0, subjects: [] ))
            } else if self.viewType == "Profile" {
                Profile(editTutor: false, editTutee: false)
            } else if self.viewType == "ChatRoom" {
                  ChatRoom()
            } else if self.viewType == "Requests" {
                MyRequests(showDialog: false, user: User(id: 0, email: "", name: "", description: "", year: 0, subjects: [] ))
            }
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

