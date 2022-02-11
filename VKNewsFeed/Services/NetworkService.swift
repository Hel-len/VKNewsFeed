//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 24.01.2022.
//

import Foundation

protocol Networking {

    var closure: (Data?, Error?) -> Void { get }
    var url: URL { get }

    func request()
}

final class NetworkService: Networking {

    var closure: (Data?, Error?) -> Void
    var url: URL

    init(url: URL, closure: @escaping (Data?, Error?) -> Void) {
        self.closure = closure
        self.url = url
    }

    func request() {
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: closure)
        task.resume()

    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
