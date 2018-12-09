//
//  CodableResponces.swift
//  Wall
//
//  Created by ILLIA HARKAVY on 12/9/18.
//  Copyright © 2018 ILLIA HARKAVY. All rights reserved.
//

import Foundation

struct VKResponse<T: Codable>: Codable {
    let response: VKResults<T>
}

struct VKResults<T: Codable>: Codable {
    let count: Int
    let items: [T]
}
