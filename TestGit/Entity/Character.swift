//
//  Character.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 11.05.2022.
//

import Foundation

struct Character: Codable {
    var charId: Int
    let name: String
    let birthday: String
    let img: String
    let status: String
    let nickname: String
    let portrayed: String
    let category: String
}
