//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 24.01.2022.
//

import Foundation


protocol DataFetcher {
    func getFeed(for apiSettings: APISettings, response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    func getFeed(for apiSettings: APISettings, response: @escaping (FeedResponse?) -> Void) {
        let api = apiSettings.currentSettings

        let requester = NetworkServiceBuilder()
            .with(scheme: api.scheme)
            .with(host: api.host)
            .with(path: api.path)
            .with(query: api.queryItems)
            .with(closure: { data, error in
                if let _ = error {
                    response(nil)
                }
                let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
                response(decoded?.response)
            })
            .build()
        if requester != nil {
            requester!.request()
        } else {
            print("Oops! nil")
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}


