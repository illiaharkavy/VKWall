//
//  Post.swift
//  Wall
//
//  Created by ILLIA HARKAVY on 12/9/18.
//  Copyright © 2018 ILLIA HARKAVY. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: Int?
    let owner_id: Int?
    let from_id: Int?
    let created_by: Int?
    let date: Int?
    let text: String?
    let reply_owner_id: Int?
    let reply_post_id: Int?
    let friends_only: Int?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    let post_type: String?
    let post_source: PostSource?
    let attachments: [Attachment]?
    let geo: String? = nil
    let signer_id: Int?
    let copy_history: [Post]?
    let can_pin: Int?
    let can_delete: Int?
    let can_edit: Int?
    let is_pinned: Int?
    let marked_as_ads: Int?
    let is_favorite: Int?
}

extension Post {
    struct Comments: Codable {
        let count: Int?
        let can_post: Int?
        let groups_can_post: Bool?
        let can_close: Bool?
        let can_open: Bool?
    }
    struct Likes: Codable {
        let count: Int?
        let user_likes: Int?
        let can_like: Int?
        let can_publish: Int?
    }
    struct Reposts: Codable {
        let count: Int?
        let user_reposted: Int?
    }
    struct Views: Codable {
        let count: Int?
    }
    struct PostSource: Codable {
        let type: String?
        let platform: String?
        let data: String?
        let url: String?
    }
    struct Attachment: Codable {
        private let type: String?
        let photo: Photo?
        let posted_photo: String? = nil
        let video: String? = nil
        let audio: String? = nil
        let doc: String? = nil
        let graffiti: String? = nil
        let link: String? = nil
        let note: String? = nil
        let app: String? = nil
        let poll: String? = nil
        let page: String? = nil
        let album: String? = nil
        let photos_list: String? = nil
        let market: String? = nil
        let market_album: String? = nil
        let sticker: String? = nil
        let pretty_cards: String? = nil
        
        struct Photo: Codable {
            let id: Int?
            let album_id: Int?
            let owner_id: Int?
            let user_id: Int?
            let text: String?
            let date: Int?
            let sizes: [Size]?
            let width: Int?
            let height: Int?
            
            struct Size: Codable {
                let type: String?
                let url: String?
                let width: Int?
                let height: Int?
            }
            
        }
        
    }
}
