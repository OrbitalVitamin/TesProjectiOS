//
//  RequestCounter.swift
//  TesProject
//
//  Created by OrbitalVitamin on 30/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import Foundation
class RequestCounter {
    
    private var counter: Int
    private let queue = DispatchQueue(label: "queue")
    
    init(amount: Int) {
        self.counter = amount
    }
    
      func decrementTilZero() -> Bool {
            queue.sync {
               self.counter -= 1
            }
                   if counter == 0 {
                       return true
                   } else {
                       return false
                   }
                   
               }
}
