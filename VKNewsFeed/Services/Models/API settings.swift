//
//  NetworkRequestBuilder.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 08.02.2022.
//

import Foundation
import UIKit

protocol URLItemsProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [String: String] { get }
}

struct URLItems: URLItemsProtocol {
    var scheme: String
    var host: String
    var path: String
    var queryItems: [String: String]
}

enum APISettings {
    case vkApiSettings

    var currentSettings: URLItemsProtocol {
        switch self {

        case .vkApiSettings:
            return URLItems(
                scheme: "https",
                host: "api.vk.com",
                path: "/method/newsfeed.get",
                queryItems: [
                    "filters": "post,photo",
                    "v": "5.131"
                ])
        }
    }
}
