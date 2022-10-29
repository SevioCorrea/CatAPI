//
//  CatsStats.swift
//  CatsAPI
//
//  Created by Sévio on 29/10/22.
//

import Foundation

struct CatsStats: Decodable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    //let reference_image_id: String
}
