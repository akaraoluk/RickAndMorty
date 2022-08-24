//
//  CharModel.swift
//  RickAndMorty
//
//  Created by Abdurrahman Karaoluk on 10.05.2022.
//

import Foundation
import UIKit

struct CharDecodeModel: Codable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: OriginModel
    let location: LocationModel
    var episode: [String]
    let image: String?
}

struct LocationModel: Codable {
    let name: String?
}

struct OriginModel: Codable {
    let name: String?
}

struct CharModel: Codable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: String?
    let location: String?
    var episode: String?
    let image: String?
}
