//
//  MessageView.swift
//  TesProject
//
//  Created by OrbitalVitamin on 24/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import Firebase

struct MessageView: View {
    @State var message: String
    let myid = Auth.auth().currentUser?.uid
    @State var chats : [Chat]
    @State  var receiverId = ""
    var ref = Database.database().reference()
    var chatName: String
    var receiverName: String

    var body: some View {
        VStack{
            List{
                ForEach(chats, id: \.self){ chat in
                    Group{
                        if chat.getSender() == self.myid{
                            HStack{
                                Spacer()
                                Message(message: chat.getMessage(), color: Color.blue)
                            }
                        } else {
                            HStack{
                                Message(message: chat.getMessage(), color: Color.green)
                                Spacer()
                            }.frame(width: 200)
                        }
                    }
                }.scaleEffect(x: 1, y: -1, anchor: .center)
            }.scaleEffect(x: 1, y: -1, anchor: .center)
        HStack{
            TextField("Type Message...", text: $message, onEditingChanged: { (changed) in
               
            }) {
                print("Username onCommit")
                }.background(Color.gray).cornerRadius(10).padding(10)
            Button(action: {
                self.sendMessage()
                       }){
                           Text("Send")
            }.padding(10)
            }
            
           
        }.onAppear() {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().tableFooterView = UIView()
            self.getUserId()
        }
    }
    
    func getUserId() {
        print(self.receiverName)
        ref.child("Users").child(self.receiverName).observeSingleEvent(of: .value, with: { (snapshot) in
            let receiverNs = snapshot.value as? NSDictionary
            self.receiverId = receiverNs?["id"] as? String ?? "id"
            self.getChats()
        })
        
    }
    
    func getChats() {
        var chatsgot: [Chat] = []
        ref.child("Chats").child(self.chatName).observe(.value) {snapshot in
            let array: NSArray = snapshot.children.allObjects as NSArray
            chatsgot.removeAll()
            for child in array {
                print("Chats before \(self.chats.count)")
                let snapshot:DataSnapshot = child as! DataSnapshot
                if let childSnapshot = snapshot.value as? [String : AnyObject] {
                    let message = childSnapshot["message"] as? String
                    let receiver = childSnapshot["receiver"] as? String
                    let sender = childSnapshot["sender"] as? String
                    chatsgot.append(Chat.init(sender: sender!, receiver: receiver!, message: message!))
                }
            }
            self.chats = chatsgot
            print("Chats after \(self.chats.count)")

        }
    }
    
    func sendMessage(){
        let chat = ["message" : self.message,
                    "receiver" : self.receiverId,
                    "sender" : self.myid]
        ref.child("Chats").child(self.chatName).childByAutoId().setValue(chat)
    }
    
   
}

struct Message: View {
    let message: String
    let color: Color

    
    var body: some View{
    
            Text(message).foregroundColor(Color.white).padding(7).background(color).cornerRadius(25)
        
    }
}

/*

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: "")
    }
} */
