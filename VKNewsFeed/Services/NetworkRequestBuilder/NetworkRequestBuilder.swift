//
//  NetworkRequestBuilder.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 08.02.2022.
//

import Foundation
import UIKit

protocol URLConstructorProtocol {
    var urlItems: URLItemsProtocol { get }
    var token: String? { get }

    func constructURL(from: URLItems) throws -> URL
}

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

class URLConstructor: URLConstructorProtocol {
    var urlItems: URLItemsProtocol
    var token: String?

    init(from urlItems: URLItemsProtocol) {
        self.urlItems = urlItems
        self.token = SceneDelegate.shared().authService.token
    }

    func constructURL(from items: URLItems) throws -> URL {
        guard let token = token else { throw ErrorHendler.noToken }

        var queryItems = items.queryItems
        queryItems["access_token"] = token
        var components = URLComponents()
        components.scheme = items.scheme
        components.host = items.host
        components.path = items.path
        components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }

        guard let url: URL = components.url else { throw ErrorHendler.wrongUrlParametres }
        return url
    }
}

protocol URLConstructorBuilderProtocol {
    func build() -> URLConstructor
}

struct VKNewsFeedApiSettings {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let newsFeed = "/method/newsfeed.get"
    static let queryItems: [String: String] = [
        "filters": "post,photo",
        "v": "5.131"
    ]
}

class URLConstructorBuilder: URLConstructorBuilderProtocol {
    let urlItems = VKNewsFeedApiSettings()
    func build() -> URLConstructor {
        let constructor = URLConstructor(from: <#T##URLItemsProtocol#>)
    }
}
