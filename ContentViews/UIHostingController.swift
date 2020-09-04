//
//  UIHostingController.swift
//  TesProject
//
//  Created by Alex Balaria on 06/06/2020.
//  Copyright © 2020 Alex Balaria. All rights reserved.
//

import SwiftUI

class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
