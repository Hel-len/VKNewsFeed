//
//  Requester.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 08.02.2022.
//

import Foundation

protocol NetworkServiceBuilderProtocol {
    var closure: ((Data?, Error?) -> Void)? { get }
    var scheme: String? { get }
    var host: String? { get }
    var path: String? { get }
    var query: [String: String]? { get }
    var token: String? { get }

    func build() -> Networking?
}

final class NetworkServiceBuilder: NetworkServiceBuilderProtocol {

    var closure: ((Data?, Error?) -> Void)?
    var scheme: String?
    var host: String?
    var path: String?
    var query: [String: String]?
    var token: String?

    init() {
        self.token = SceneDelegate.shared().authService.token
    }

    func with(closure: @escaping (Data?, Error?) -> Void) -> NetworkServiceBuilder {
        self.closure = closure
        return self
    }

    func with(scheme: String) -> NetworkServiceBuilder {
        self.scheme = scheme
        return self
    }

    func with(host: String) -> NetworkServiceBuilder {
        self.host = host
        return self
    }

    func with(path: String) -> NetworkServiceBuilder {
        self.path = path
        return self
    }

    func with(query: [String: String]) -> NetworkServiceBuilder {
        self.query = query
        return self
    }

    private func buildURL() throws -> URL {
        guard let token = token else { throw ErrorHandler.noToken }

        guard var queryItems = query else { throw ErrorHandler.WrongUrlParametres.query }
        guard let scheme = scheme else { throw ErrorHandler.WrongUrlParametres.scheme }
        guard let host = host else { throw ErrorHandler.WrongUrlParametres.host }
        guard let path = path else { throw ErrorHandler.WrongUrlParametres.path }
        queryItems["access_token"] = token
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }

        guard let url: URL = components.url else { throw ErrorHandler.WrongUrlParametres.unknown }
        return url
    }

    func build() -> Networking? {
        do {
        let url = try buildURL()
            let networkService = NetworkService(url: url, closure: closure!)
            return networkService
        } catch ErrorHandler.noToken {
            print("\(ErrorHandler.noToken.error): \(ErrorHandler.noToken.localizedDescription)")
        } catch ErrorHandler.error {
            print("\(ErrorHandler.error.error): \(ErrorHandler.error.localizedDescription)")
        } catch ErrorHandler.WrongUrlParametres.scheme {
            print("\(ErrorHandler.WrongUrlParametres.scheme.error)")
        } catch ErrorHandler.WrongUrlParametres.host {
            print("\(ErrorHandler.WrongUrlParametres.host.error)")
        } catch ErrorHandler.WrongUrlParametres.path {
            print("\(ErrorHandler.WrongUrlParametres.path.error)")
        } catch ErrorHandler.WrongUrlParametres.query {
            print("\(ErrorHandler.WrongUrlParametres.query.error)")
        } catch ErrorHandler.WrongUrlParametres.unknown {
            print("\(ErrorHandler.WrongUrlParametres.unknown.error)")
        } catch {
            print("Unknown error")
        }

        return nil
    }
}

enum ErrorHandler: Error {
    case noToken
    enum WrongUrlParametres: Error {
        case scheme
        case host
        case path
        case query
        case unknown

        var error: String {
            switch self {

            case .scheme:
                return "scheme is nil or invalid: \(self.localizedDescription)"
            case .host:
                return "host is nil or invalid: \(self.localizedDescription)"
            case .path:
                return "path is nil or invalid: \(self.localizedDescription)"
            case .query:
                return "query is nil or invalid: \(self.localizedDescription)"
            case .unknown:
                return "Unknown error: \(self.localizedDescription)"
            }
        }
    }
    case error

    var error: String {
        switch self {
        case .noToken: return "Token is nil or invalid: \(self.localizedDescription)"
        case .error: return "Some error handled, we don't know what is it: \(self.localizedDescription)"
        }
    }
}
