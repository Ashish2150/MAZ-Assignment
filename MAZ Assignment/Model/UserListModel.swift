//
//  UserListModel.swift
//  MAZ Assignment
//
//  Created by Ashish on 26/06/20.
//  Copyright © 2020 Ashish. All rights reserved.
//

import Foundation

struct UserListModel: Codable {
    let id: Int?
    let firstName, lastName, email, gender: String?
    let message, ipAddress: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, gender, message
        case ipAddress = "ip_address"
    }
}
