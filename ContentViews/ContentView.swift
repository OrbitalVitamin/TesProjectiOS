//
//  LoginView.swift
//  TesProject
//
//  Created by Alex Balaria on 24/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
 
    var body: some View {
        
        Group{
            if session.isLoggedIn == "Main" {
                MainView()
            } else if session.isLoggedIn == "Register"{
                RegisterView(name: session.name, email: session.email, viewType: "", tutorSubjects: [], tuteeSubjects : [], year: 0, tutorDescription: "", tuteeDescription: "", editType: "")
            } else {
                LoginView()
            }
            }.onAppear(perform: getUser)
    }
    
    
    func getUser(){
        session.listen()
    
    }
}

struct google : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
}

struct LoginView: View {
    var body: some View {
        google().frame(width: 120, height: 50)
    }
    
}




private class Response: Codable {
    var user: User
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

