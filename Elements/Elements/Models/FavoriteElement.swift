//
//  FavoriteElement.swift
//  Elements
//
//  Created by Manny Yusuf on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct FavoriteElement: Codable {
    let trackId: Int 
    let elementName: String
    let favoritedBy: String
    let elementSymbol: String
}

