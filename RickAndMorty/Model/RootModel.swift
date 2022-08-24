//
//  RootModel.swift
//  RickAndMorty
//
//  Created by Abdurrahman Karaoluk on 10.05.2022.
//

import Foundation

struct InfoModel :Codable {
    var count: Int
    var pages: Int
    var next: String
    var prev: String?
}



struct RootModel: Codable {
    let info: InfoModel
    let results: [CharDecodeModel]
}
