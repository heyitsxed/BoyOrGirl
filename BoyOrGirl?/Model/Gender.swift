//
//  Gender.swift
//  BoyOrGirl?
//
//  Created by Cedrick on 2/11/26.
//

struct GenderResponse: Codable {
    let count: Int
    let name: String
    let gender: String
    let probability: Float
}
