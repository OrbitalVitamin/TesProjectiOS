//
//  UserListItem.swift
//  TesProject
//
//  Created by OrbitalVitamin on 26/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI

struct UserListItem: View {
    var user: User
    
    
    var body: some View {
        GeometryReader { metrics in
            HStack(spacing: 25){
            
                VStack(spacing: 5){
                    HStack{
                       Text(user.getName()).padding(.bottom).font(.system(size: 15))
                        Spacer()
                        
                        Text("Year: \(user.getYear())").padding(.bottom).font(.system(size: 15))

                    }
                    HStack{
                        Text("Subjects: " + stringBuilder(strings: user.getSubjects())).font(.system(size: 12))
                        Spacer()

                    }
                    HStack{
                        Text("decription: " + user.getDescription()).font(.system(size: 12))
                        Spacer()
                    }
                }
                
                
            }.padding(15).frame(width: metrics.size.width).overlay(RoundedRectangle (cornerRadius: 25).stroke(Color.gray).shadow(radius: 5))
            }
    
    }
    
    func stringBuilder(strings: [String]) -> String {
        var resultString = ""
        for string in strings{
            if string != strings[0]{
                resultString = resultString + ", " + string
            } else {
                resultString = resultString + string
            }
        }
        return resultString
    }
}

struct UserListItem_Previews: PreviewProvider {
    static var previews: some View {
        UserListItem(user: User.init(id: 3, email: "Email", name: "Name Surname", description: "Something written about myself", year: 5, subjects: ["Maths", "Physics"]))
    }
}
