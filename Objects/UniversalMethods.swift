//
//  UniversalMethods.swift
//  TesProject
//
//  Created by Alex Balaria on 30/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import Foundation

class UniversalMethods {
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
    
    func parseJsonSubjects(data: Data) -> [String] {
        do{
            let response = try JSONDecoder().decode(subjectsResponse.self, from: data)
            let subjects = response.subjects
            return subjects
        } catch {
            return []
        }
    }
    
    private struct subjectsResponse: Decodable {
        var subjects: [String]
    }

    
    
    
}
