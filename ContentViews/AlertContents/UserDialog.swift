//
//  UserDialog.swift
//  TesProject
//
//  Created by OrbitalVitamin on 30/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI

struct UserDialog: View {
    var user: User
    @Binding var showDialog: Bool
    var universalMethods = UniversalMethods()
    @State var userType = ""
    @State var windowType: String
    @State var chatName = ""
    @State var goToMessage : Bool? = false
    var buttonText: String
    
    
    var body: some View {
        VStack(spacing: 15) {
            
            HStack{
                Text(user.getName())
                Spacer()
                Text("Year: " + "\(user.getYear())")
            }
            
            Text("subjects: " + universalMethods.stringBuilder(strings: user.getSubjects()))
            
            Text("description: " + user.getDescription())
            
            
            HStack(){
                Button(action: {
                    self.showDialog = false
                }){
                    Text("cancel").foregroundColor(Color.gray)
                }
                
                
                Spacer()
                Button(action: {
                    var userYear: Int
                    var userId: Int
                    var tuteeId: Int
                    var tutorId: Int
                    var userName: String
                    
                    if SingletonUserTutor.tutor.tutorExists {
                        userYear = SingletonUserTutor.tutor.user?.getYear() as! Int
                        userId = SingletonUserTutor.tutor.user?.getId() as! Int
                        userName = SingletonUserTutor.tutor.user?.getName() as! String
                    } else {
                        userYear = SingletonUserTutee.tutee.user?.getYear() as! Int
                        userId = SingletonUserTutee.tutee.user?.getId() as! Int
                        userName = SingletonUserTutee.tutee.user?.getName() as! String
                    }
                    
                    if userYear > self.user.getYear() {
                        tuteeId = self.user.getId()
                        tutorId = userId
                        self.userType = "tutor"
                    } else {
                        tutorId = self.user.getId()
                        tuteeId = userId
                        self.userType = "tutee"
                    }
                   
                    
                    if self.windowType == "home"{
                        Api().setData(restOfUrl: "/" + self.userType + "s/save_request/\(tuteeId)/\(tutorId)" )
                        self.showDialog = false
                    } else if self.windowType == "Requests"{
                        Api().setData(restOfUrl: "/" + self.userType + "s/save_ " + self.userType + "/\(tuteeId)/\(tutorId)")
                        self.showDialog = false
                    } else if self.windowType == "Matches" {
                        
                        Api().getData(restOfUrl: "/general/find_chat_exist/" + userName + "/" + self.user.getName())
                        { (data) in
                            self.chatName = self.parseJson(data: data).getChatName()
                            if self.chatName != "" {
                                print("if called")
                                self.goToMessage = true
                            } else {
                                self.chatName = userName + "-" + self.user.getName() + "-chat"
                                Api().setData(restOfUrl: "/general/create_chat/\(userName)/\(self.user.getName())/\(self.chatName)")
                                self.goToMessage = true

                            }
                        }
                    }
                    
                }){
                    Text(self.buttonText).foregroundColor(Color.gray)
                }
            
                
                
            }
            HStack{
                
                NavigationLink(destination: MessageView(message: "", chats: [], chatName: self.chatName, receiverName: self.user.getName()), tag: true, selection: self.$goToMessage){
                                    Text("")
                                }
                Spacer()
                if self.windowType == "Matches" {
                       Button(action: {
                                     }) {
                                        Text("Remove Match").foregroundColor(Color.black)
                                     }
                }
             
            }
          
        }.background(Color.white).frame(width: 300, height: 200).background(Color.white).onAppear() {
            
        }
        
      
    }
    func parseJson(data: Data) -> ChatName{
        var chatName : ChatName
            do{
                let response = try JSONDecoder().decode(Response1.self, from: data)
                chatName = response.name
                return chatName
            } catch {
                print("Parsing Failed")
                print(error.localizedDescription)
                print("Parsing Failed")

                return ChatName(username: "", chatName: "")
            }
        }
    }

    private struct Response1: Codable {
        var name: ChatName
    }

/*
struct UserDialog_Previews: PreviewProvider {
    static var previews: some View {
        UserDialog(user: User(id: 2, email: "example@gmail.com", name: "Pepik", description: "lidi existujou", year: 5, subjects: ["Geography", "English", "Czech"]), showDialog: false, windowType: "Matches")
    }
} */
