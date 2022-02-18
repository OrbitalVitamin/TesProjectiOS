//
//  ChatRoom.swift
//  TesProject
//
//  Created by OrbitalVitamin on 24/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI

struct ChatRoom: View {
    @State var chatNames: [IdentifibleChatName] = []
    var body: some View {
        List (self.chatNames){ chatName in
            ChatRoomListItem(username: chatName.getUsername(), lastMessage: "Last Message", chatName: chatName.getChatName())
        }.onAppear() {
            UITableView.appearance().separatorStyle = .singleLine
            Api().getData(restOfUrl: "/general/find_chats/" + self.getUsername()) { (data) in

                self.chatNames = self.parseJson(data: data)
            }
        }
    }
    func getUsername() -> String {
        if SingletonUserTutee.tutee.tuteeExists == true {
            return (SingletonUserTutee.tutee.user?.getName())!
        } else {
             return (SingletonUserTutor.tutor.user?.getName())!
        }
    }
    
    func parseJson(data: Data) -> [IdentifibleChatName]{
        do{
            let response = try JSONDecoder().decode(Response1.self, from: data)
            let chatNames = response.chatName
            var identifibleChatNames: [IdentifibleChatName] = []
            var i = 0
            for chatName in chatNames {
                identifibleChatNames.append(IdentifibleChatName(id: i, username: chatName.getUsername(), chatName: chatName.getChatName()))
                i += 1
            }
            return identifibleChatNames
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

private struct Response1: Codable {
    var chatName: [ChatName]
}

struct IdentifibleChatName: Codable, Identifiable {
    internal var id: Int
    private var username: String
    private var chatName: String
    
    init(id: Int, username: String, chatName: String){
        self.id = id
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



struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom()
    }
}
