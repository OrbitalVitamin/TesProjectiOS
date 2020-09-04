//
//  File.swift
//  TesProject
//
//  Created by Alex Balaria on 29/05/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import Foundation

struct SingletonUserTutor{
    static var tutor = SingletonUserTutor()
    var user: User? = nil
    var tutorExists: Bool = false
    
    private init() {}
}
