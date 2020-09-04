//
//  MenuView.swift
//  TesProject
//
//  Created by Alex Balaria on 24/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import SwiftUI
import Firebase

struct MenuView: View {
    
    @Binding var viewType : String

    static let ecp_blue = Color("ecp_blue")
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Image("ic_ecp_logo").resizable().frame(width: 115, height:115).padding(5)
                HStack{
                    Text((Auth.auth().currentUser?.displayName)!).padding(5).foregroundColor(Color.white).font(.system(size: 15)).padding(5)
                    Spacer()
                }
                HStack{
                    Text((Auth.auth().currentUser?.email)!).padding(5).foregroundColor(Color.white).font(.system(size: 12)).padding(5)
                    Spacer()
                }
            }.frame(width: 250).background(MenuView.ecp_blue).padding(.top, 80)
            
            VStack(alignment: .leading){
                Button(action:{
                    self.viewType = "Home"
                    
                }) {
                    Text("Home").padding(15).foregroundColor(Color.black)
                }
                
                Button(action:{
                    self.viewType = "Profile"
                }) {
                    Text("Profile").padding(15).foregroundColor(Color.black)
                    }
                
                Button(action:{
                    self.viewType = "Matches"
                }) {
                    Text("Matches").padding(15).foregroundColor(Color.black)
                }
                
                Button(action:{
                    self.viewType = "ChatRoom"
                }) {
                    Text("Chat Room").padding(15).foregroundColor(Color.black)
                }
                
                Button(action:{
                    self.viewType = "Requests"
                }) {
                    Text("Requests").padding(15).foregroundColor(Color.black)
                }
            }.frame(width: 150).background(Color.white)
                Spacer()
        }.frame(maxWidth: .infinity, alignment: .leading)
            .edgesIgnoringSafeArea(.all).background(Color.white)
    }
    
    private func link<Destination: View>(label: String, destination: Destination) -> some View {
        return NavigationLink(destination: destination) {
                Text(label)
        }
    }
}

/*
struct menuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewType: "Home")
    }
} */

