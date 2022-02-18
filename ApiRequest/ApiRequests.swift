//
//  ApiRequests.swift
//  TesProject
//
//  Created by OrbitalVitamin on 28/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import Foundation

struct retrievedData: Codable {
    let data: Data
}


class Api {
    let urlString = "http://localhost:8090"
    func getData(restOfUrl: String, completion: @escaping (Data) -> ()) {
        let mergedUr = urlString + restOfUrl
        let correctedUrl = mergedUr.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: correctedUrl) else {
            print(urlString + restOfUrl)
            print("Invalid URL")
            return}
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                
                completion(data!)
            }
        }.resume()
        
    }
    
    func setData(restOfUrl: String) {
        let mergedUr = urlString + restOfUrl
        let correctedUrl = mergedUr.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: correctedUrl) else {
            print("Invalid URL")
            return
        }
                
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                print("done")
            }
        }.resume()
    
    }
    
    func postRequest(restOfUrl: String, user: User, completion: @escaping (Data) -> ()){
        guard let encoded = try? JSONEncoder().encode(user) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: urlString + restOfUrl)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        print(String(decoding: encoded, as: UTF8.self))
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                
                print("Data before Completion")
                let str = String(decoding: data!, as: UTF8.self)
                print(str)
                completion(data!)
            }
        }.resume()
        
    }
    
    func generalPostRequest(restOfUrl: String, data: Data){
        
        let url = URL(string: urlString + restOfUrl)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = data
        print(String(decoding: data, as: UTF8.self))
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
            }
        }.resume()
        
    }
    
    
}


// .onAppear(perform: loadData)










