//
//  SingletonUserTutee.swift
//  TesProject
//
//  Created by OrbitalVitamin on 29/05/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import Foundation

struct SingletonUserTutee{
    static var tutee = SingletonUserTutee()
    var user: User? = nil
    var tuteeExists: Bool = false
    
    private init() {}
}
