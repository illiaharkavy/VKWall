//
//  VK.swift
//  Wall
//
//  Created by ILLIA HARKAVY on 12/9/18.
//  Copyright © 2018 ILLIA HARKAVY. All rights reserved.
//

import Moya

public enum VK {
    
    static private let accessToken = "e78cd613e78cd613e78cd61327e7ebbd2dee78ce78cd613bb818392820453f3d1403ce4"
    static private let version = "5.92"
    
    case wallPosts(id: String, count: Int)
}

extension VK: TargetType {

    public var baseURL: URL {
        return URL(string: "https://api.vk.com")!
    }
    
    public var path: String {
        switch self {
        case .wallPosts(id: _): return "/method/wall.get"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .wallPosts(id: _): return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        
        switch self {
        case .wallPosts(id: let id, count: let count):
            // 3
            return .requestParameters(
                parameters: [
                    "owner_id": id,
                    "count": count,
                    "access_token": VK.accessToken,
                    "v": VK.version
                ],
                encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
