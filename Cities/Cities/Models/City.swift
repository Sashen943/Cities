//
//  City.swift
//  Cities
//
//  Created by Sashen Pillay on 2021/05/03.
//

import Foundation

struct City: Codable {
    var country: String
    var name: String
    var _id: Int
    var coord: Coord
}
