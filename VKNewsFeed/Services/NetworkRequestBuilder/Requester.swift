//
//  Requester.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 08.02.2022.
//

import Foundation

protocol RequestProtocol {
    var request: URLRequest { get }
    var errorHendler: ErrorHendler? { get }

    func createData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask
}

enum ErrorHendler: Error {
    case noToken
    case wrongUrlParametres
    case error

    var error: String {
        switch self {
        case .noToken: return "Token is nil or invalid"
        case .error: return "Some error handled, we don't know what is it"
        case .wrongUrlParametres: return "One or more URL parametres are wrong! Cant build correct URL"
        }
    }
}

//enum Result<T: Codable> {
//    case success(T)
//    case failure(ErrorHendler)
//}
//
//class Requester: RequestProtocol {
//
//    var errorHendler: ErrorHendler?
//    var request: URLRequest
//
//    init(request: URLRequest, errorHendler: ErrorHendler?) {
//        self.request = request
//        self.errorHendler = errorHendler
//    }
//
//    func createData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
//        return URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                completion(data, error)
//            }
//        }
//    }
//}
//
//protocol RequestBuilderProtocol {
//    func build() -> Requester
//}
//
//class RequestBuilder: RequestBuilderProtocol {
//    var url: URL?
//    var request: URLRequest?
//    var error: ErrorHendler?
//
//    func setUrl() -> RequestBuilder {
//        guard let token = SceneDelegate.shared().authService.token else {
//            self.error = .error
//            return self
//        }
//        var params = ["filters": "post,photo"]
//        params["access_token"] = token
//        params["v"] = API.version
//        var components = URLComponents()
//        components.scheme = API.scheme
//        components.host = API.host
//        components.path = API.newsFeed
//        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
//
//        self.url = components.url
//        return self
//    }
//
//    func request(completion: @escaping (Data?, Error?) -> Void) -> RequestBuilder {
//
//        guard let url = self.url else {
//            self.error = .error
//            return self
//        }
//
//        let request = URLRequest(url: url)
//        self.request = request
//        return self
//    }
//
//    func build() -> Requester {
//        guard let request = request else {
//            fatalError("Request error")
//        }
//
//        let requester = Requester(request: request, errorHendler: error)
//        return requester
//    }
//}
//
//struct NetworkDataFetcher2 {
//
//    func getFeed() -> FeedResponse {
//        let requester = RequestBuilder().build()
//    }
//}
