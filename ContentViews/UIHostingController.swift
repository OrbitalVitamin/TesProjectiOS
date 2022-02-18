//
//  UIHostingController.swift
//  TesProject
//
//  Created by OrbitalVitamin on 06/06/2020.
//  Copyright © 2020 OrbitalVitamin. All rights reserved.
//

import SwiftUI

class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
