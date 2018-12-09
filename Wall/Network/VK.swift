//
//  VK.swift
//  Wall
//
//  Created by ILLIA HARKAVY on 12/9/18.
//  Copyright © 2018 ILLIA HARKAVY. All rights reserved.
//

import Moya

enum VK {
    
    static private let accessToken = "e78cd613e78cd613e78cd61327e7ebbd2dee78ce78cd613bb818392820453f3d1403ce4"
    static private let version = "5.92"
    
    case wallPosts(string: String, type: RequestType, count: Int)
    
    enum RequestType {
        case ownerID
        case domain
    }
    
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
        case .wallPosts: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        
        switch self {
        case .wallPosts(string: let string, type: let type, count: let count):
            var parameters: [String: Any] = [
                "count": count,
                "access_token": VK.accessToken,
                "v": VK.version
            ]
            switch type {
            case .domain:
                parameters["domain"] = string
            case .ownerID:
                parameters["owner_id"] = string
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
