//
//  Profile.swift
//  TesProject
//
//  Created by Alex Balaria on 24/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import SwiftUI
import Firebase


private var string: String?

struct Profile: View {
    @EnvironmentObject var session: SessionStore
    @State var activeTutor = false
    @State var activeTutee = false
    @State var editTutor: Bool
    @State var editTutee: Bool
    @State var tutorDescription = ""
    @State var tuteeDescription = ""
    @State var tutorSubjects: [String] = []
    @State var tuteeSubjects: [String] = []
    @State var viewType: String = ""
    @State var subjects: [String] = []
    @State var navigation: Bool? = false
    let tutorExists = SingletonUserTutor.tutor.tutorExists
    let tuteeExists = SingletonUserTutee.tutee.tuteeExists
    
    var body: some View {
        
        ZStack{
            VStack (spacing: 20) {
                HStack {
                VStack (spacing: 20){
                NavigationLink(destination: MainView(), tag: true, selection: self.$navigation){
                         Text("")
                     }
                    if tutorExists{
                        Toggle(isOn:$activeTutor){
                            Text("active tutor")
                        }.frame(width: 150)
                    }
                    
                    if tuteeExists{
                        Toggle(isOn:$activeTutee){
                            Text("active tutee")
                        }.frame(width: 150)
                    }
                    
                    if tutorExists {
                        Toggle(isOn:$editTutor){
                            Text("Edit Tutor Account")
                        }.frame(width: 150)
                    }
                    
                    if editTutor {
                          VStack{
                            Button(action: {
                                self.viewType = "tutor"
                            }) {
                                Text("Change Tutor Subjects")
                            }
                                TextField("Enter Tutor Description...", text: $tutorDescription).frame(width: 150, height: 100)
                          }.transition(.opacity)
                    }

                    if tuteeExists{
                        Toggle(isOn:$editTutee){
                            Text("Edit Tutee Account")
                        }.frame(width: 150)
                    }
                        
                    if editTutee {
                        VStack{
                            
                            Button(action: {
                                self.viewType = "tutee"
                            }) {
                                Text("Change Tutee Subjects")
                            }
                            
                            TextField("Enter Tutee Description...", text: $tuteeDescription).frame(width: 150, height: 100)
                            
                            }.transition(.opacity)
                        
                 
                           
                    }
                    }.padding()
                    Spacer()
                }
                Spacer()
                HStack {
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                        } catch {
                            
                        }
                    }) {
                        Text("Sign Out")
                    }.padding()
                    
                    Spacer()
                    
                 
                    
                    
                    if !tuteeExists {
                        Button(action: {
                            self.navigation = true
                        }) {
                            Text("Create Tutee Account")
                        }.padding()
                    } else if !tutorExists{
                        Button(action: {
                            self.navigation = true
                        }) {
                            Text("Create Tutee Account")
                        }.padding()
                    }
                    Spacer()
                    
                    Button(action: {
                        self.checkChange()
                    }) {
                        Text("Confirm changes")
                    }.padding()
                    
                }
                

            
            }.onAppear() {
                Api().getData(restOfUrl: "/general/subjects") { (data) in
                               self.subjects = UniversalMethods().parseJsonSubjects(data: data)
                           }
                if SingletonUserTutor.tutor.tutorExists{
                    Api().getData(restOfUrl: "/tutors/find_if_user_active/\(SingletonUserTutor.tutor.user?.getId() ?? 0)"){ (data) in
                        self.activeTutor = self.parseJson(data: data)
                    }
                    print(self.tuteeExists)
                    print(self.tutorExists)
                }
                
                if SingletonUserTutee.tutee.tuteeExists{
                    Api().getData(restOfUrl: "/tutees/find_if_user_active/\(SingletonUserTutee.tutee.user?.getId() ?? 0 )"){ (data) in
                        self.activeTutee = self.parseJson(data: data)
                    }
                }
                

            }
            
          GeometryReader {_ in
                MultiSelectionList(subjects: self.$subjects, selections: self.$tutorSubjects, viewType: self.$viewType)
            }.background(Color.black.opacity(0.65)).opacity(self.viewType == "tutor"  ? 1 : 0)
                       
            GeometryReader {_ in
                MultiSelectionList(subjects: self.$subjects, selections: self.$tuteeSubjects, viewType: self.$viewType)
            }.background(Color.black.opacity(0.65)).opacity(self.viewType == "tutee"  ? 1 : 0)
     
        }
      
    }
    

    
    func parseJson(data: Data) -> Bool {
        do{
            let response = try JSONDecoder().decode(Response.self, from: data)
            let bool = response.boolean
            return bool
        } catch {
            return false
        }
    }
    
    func checkChange() {
        if editTutor{
            if self.tutorDescription != "" {
                guard let encoded = try? JSONEncoder().encode(self.tutorDescription) else {
                     print("Failed to encode")
                     return
                 }
                Api().generalPostRequest(restOfUrl:  "tutors/change_description/\(SingletonUserTutor.tutor.user?.getId())", data: encoded)
            }
            
            if self.tutorSubjects != []{
                guard let encoded = try? JSONEncoder().encode(self.tutorSubjects) else {
                     print("Failed to encode")
                     return
                 }
                Api().generalPostRequest(restOfUrl:  "tutors/change_subjects/\(SingletonUserTutor.tutor.user?.getId())", data: encoded)
            }
        }
        
        if editTutee {
            if self.tuteeDescription != "" {
                guard let encoded = try? JSONEncoder().encode(self.tuteeDescription) else {
                     print("Failed to encode")
                     return
                 }
                Api().generalPostRequest(restOfUrl:  "tutees/change_description/\(SingletonUserTutee.tutee.user?.getId())", data: encoded)
            }
            
            if self.tuteeSubjects != [] {
                guard let encoded = try? JSONEncoder().encode(self.tuteeSubjects) else {
                     print("Failed to encode")
                     return
                 }
                Api().generalPostRequest(restOfUrl:  "tutees/change_subjects/\(SingletonUserTutee.tutee.user?.getId())", data: encoded)
            }
        }
    }
}

private struct Response: Decodable {
    var boolean: Bool
}


struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(editTutor: false, editTutee: false)
    }
}
