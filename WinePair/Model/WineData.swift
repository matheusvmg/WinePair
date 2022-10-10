//
//  WineData.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

struct WineData: Codable, Equatable {
    let pairedWines: [String]?
    let pairingText: String?
    let productMatches: [Wine]?
}

struct Wine: Codable, Equatable {
    let id: Int?
    let title: String?
    let averageRating: Double?
    let description: String?
    let imageUrl: String?
    let link: String?
    let price: String?
    let ratingCount: Double?
    let score: Double?
    
    static func configureWhenIsNil() -> Wine {
        return Wine(id: 0, title: "", averageRating: 0, description: "", imageUrl: "", link: "", price: "", ratingCount: 0, score: 0)
    }
}
