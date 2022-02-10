//
//  API.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 24.01.2022.
//  24.01.2022 actual version VK API 5.131
//  SDK version 1.6.2 feb2021

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"

    static let newsFeed = "/method/newsfeed.get"
}
