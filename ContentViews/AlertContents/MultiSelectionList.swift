//
//  MultiSelectionList.swift
//  TesProject
//
//  Created by Alex Balaria on 25/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import SwiftUI

struct MultiSelectionList: View {
    @Binding var subjects: [String]
    @Binding var selections: [String]
    @Binding var viewType: String
    
    var body: some View {
        VStack{
            List{
                ForEach(self.subjects, id: \.self){ subject in
                    MultipleSelectionRow(title: subject, isSelected: self.selections.contains(subject)){
                        if self.selections.contains(subject){
                            self.selections.removeAll(where: { $0 == subject})
                        } else {
                            self.selections.append(subject)
                        }
                    }
                }
            }.frame(width: 250, height: 200).background(Color.white)
            HStack(spacing: 150){
                Button(action: {
                    self.selections.removeAll()
                    self.viewType = ""
                }){
                    Text("cancel").foregroundColor(Color.gray)
                }
                
                Button(action: {
                    self.viewType = ""
                }){
                    Text("ok").foregroundColor(Color.gray)
                }
            }
        }.background(Color.white)
        
    }
    
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
/*
struct MultiSelectionList_Previews: PreviewProvider {
    static var previews: some View {
        MultiSelectionList()
    }
} */
