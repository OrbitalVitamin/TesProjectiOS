//
//  RegisterView.swift
//  TesProject
//
//  Created by Alex Balaria on 24/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    var name: String
    var email: String
    @State var viewType: String
    @State var tutorSubjects: [String]
    @State var tuteeSubjects: [String]
    @State var subjects: [String] = []
    var years = [1,2,3,4,5,6]
    @State var year: Int
    @State private var showTutor = false
    @State private var showTutee = false
    @State var tutorDescription: String
    @State var tuteeDescription: String
    @State var registered: Bool?
    @State var editType: String

    
    
    var body: some View {
        ZStack{
            VStack(spacing: 20) {

                Group{
                    VStack(spacing: 20){
                        VStack(spacing: 10){
                            Text(self.email)
                            Text(self.name)
                        }
                        HStack{
                            Spacer()
                            Text("Select Year: ")
                            Spacer()
                            Spacer()
                        }
                    }
                }
           
            
                Picker("", selection: self.$year){
                    ForEach(0 ..< self.years.count){
                        Text("\(self.years[$0])")
                    }
                }.labelsHidden().frame(width: 250, height: 150).opacity(self.editType == "tutee" || self.editType == "tutor"  ? 1 : 0)
                
                VStack(spacing: 25){
                Group{
                    Toggle(isOn: $showTutor){
                        Text("Create Tutor Account")
                    }.frame(width: 250)
                
                Button(action:{
                    self.viewType = "tutor"
                    }){
                        Text("Select Tutor Subjects").padding(10).opacity(self.showTutor == true ? 1 : 0)
                    }
                
                 TextField("Enter Tutor Description...", text: $tutorDescription, onEditingChanged: { (changed) in
                               print("Username onEditingChanged - \(changed)")
                           }) {
                               print("Username onCommit")
                 }.opacity(self.showTutor == true ? 1 : 0)
                    }.opacity(self.editType == "tutor" ? 1 : 0)
                
                Group {
                
                Toggle(isOn: $showTutee){
                                      Text("Create Tutee Account")
                                  }.frame(width: 250)
                              
                              Button(action:{
                                    self.viewType = "tutee"
                                  }){
                                      Text("Select Tutee Subjects").padding(10).opacity(self.showTutee == true ? 1 : 0)
                              }
                              
                TextField("Enter Tutor Description...", text: $tuteeDescription, onEditingChanged: { (changed) in
                                print("Username onEditingChanged - \(changed)")
                            }) {
                                print("Username onCommit")
                            }.opacity(self.showTutee == true ? 1 : 0)
                    }.opacity(self.editType == "tutee" ? 1 : 0)
                    
                }
                
                HStack{
                    Spacer() ; Spacer()
                    Spacer() ; Spacer()
                    Spacer() ; Spacer()
                    NavigationLink(destination: MainView(), tag: true, selection: self.$registered){
                             Text("")
                         }
                    Button(action: {
                        var amount = 0
                        if self.showTutee {
                            amount += 1
                        }
                        
                        if self.showTutee {
                            amount += 1
                        }
                        let requestCounter = RequestCounter(amount: amount)
                        
                        if self.showTutor {
                           
                            let tutor = User(id: 0, email: self.email, name: self.name, description: self.tutorDescription, year: self.year+1, subjects: self.tutorSubjects)
                        
                            Api().postRequest(restOfUrl: "/tutors/create", user: tutor) { (data) in
                                let user = self.parseJson(data: data)
                                if user != nil {
                                    SingletonUserTutor.tutor.user = user
                                    SingletonUserTutor.tutor.tutorExists = true
                                }
                                
                                if requestCounter.decrementTilZero(){
                                    self.registered = true
                                }
                            }
                        }
                        
                        if self.showTutee {
                        
                            let tutee = User(id: 0, email: self.email, name: self.name, description: self.tuteeDescription, year: self.year+1, subjects: self.tuteeSubjects)
                                Api().postRequest(restOfUrl: "/tutees/create", user: tutee) { (data) in
                                   
                                    let user = self.parseJson(data: data)
                                    if user != nil {
                                        SingletonUserTutee.tutee.user = user
                                        SingletonUserTutee.tutee.tuteeExists = true
                                    }

                                    if requestCounter.decrementTilZero(){
                                        self.registered = true
                                    }
                                }
                        }
                        
                        
                        
                    
                    }) {
                        Text("Register")
                    }
                    Spacer(); Spacer()
                }
                
                Spacer()
            }
            
            GeometryReader {_ in
                MultiSelectionList(subjects: self.$subjects, selections: self.$tutorSubjects, viewType: self.$viewType)
            }.background(Color.black.opacity(0.65)).opacity(self.viewType == "tutor"  ? 1 : 0)
            
            GeometryReader {_ in
                MultiSelectionList(subjects: self.$subjects, selections: self.$tuteeSubjects, viewType: self.$viewType)
            }.background(Color.black.opacity(0.65)).opacity(self.viewType == "tutee"  ? 1 : 0)
        }.onAppear() {
            Api().getData(restOfUrl: "/general/subjects") { (data) in
                self.subjects = UniversalMethods().parseJsonSubjects(data: data)
            }
        }
    }
    
    func parseJson(data: Data) -> User? {
        do{
            let response = try JSONDecoder().decode(Response.self, from: data)
            let user = response.user
            print(user.getId())
            return user
        } catch {
            return nil
        }
    }
}

private class Response: Codable {
    var user: User
}




struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(name: "", email: "", viewType: "", tutorSubjects: [], tuteeSubjects : [], year: 0, tutorDescription: "", tuteeDescription: "", editType: "")
    }
}

