//
//  AtomicElements.swift
//  Elements
//
//  Created by Manny Yusuf on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    var symbol: String
    var name: String
    var atomic_mass: Double
    var melt: Double?
    var boil: Double?
    var discovered_by: String?
    var number: Int
}
