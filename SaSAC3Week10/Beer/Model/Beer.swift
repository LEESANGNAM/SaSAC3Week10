//
//  Beer.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/19.
//

import Foundation

struct Beer: Decodable {
    let id: Int
    let name, tagline, firstBrewed, description: String
    let imageURL: String
    let abv: Double //abv 도수
//    let ibu, targetFg, targetOg: Int
//    let ebc: Int
//    let srm, ph, attenuationLevel: Double
//    let volume, boilVolume: BoilVolume
//    let method: Method
//    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips, contributedBy: String

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case abv
//        case ibu
//        case targetFg = "target_fg"
//        case targetOg = "target_og"
//        case ebc, srm, ph
//        case attenuationLevel = "attenuation_level"
//        case volume
//        case boilVolume = "boil_volume"
//        case method, ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}
