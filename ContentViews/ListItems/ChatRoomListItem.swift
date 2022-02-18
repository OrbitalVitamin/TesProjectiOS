//
//  SwiftUIView.swift
//  TesProject
//
//  Created by OrbitalVitamin on 30/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI

struct ChatRoomListItem: View {
    var username: String
    var lastMessage: String
    var chatName: String
    @State var goToMessage: Bool?
    
    var body: some View {
        VStack{
            NavigationLink(destination: MessageView(message: "", chats: [], chatName: self.chatName, receiverName: self.username), tag: true, selection: self.$goToMessage){
                Text("")
            }
            HStack(spacing: 10){
                Text (self.username)
                Spacer()
            }.padding(10)
            HStack{
                Spacer()
                Text (self.lastMessage)
                Spacer()
                Spacer()
            }
        }.frame(width: 400, height: 75).onTapGesture {
            self.goToMessage = true
        }
       
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomListItem(username: "Username", lastMessage: "Last Message", chatName: "Something")
    }
}
