//
//  APIClient.swift
//  InstaSwiftUI
//
//  Created by Dhaval Trivedi on 15/04/23.
//

import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient(searchString: "People") // default search string
// https://api.pexels.com/v1/search?query=people
    let baseURL = "https://api.pexels.com/v1/"
    var searchString = ""
    private init(searchString: String) {
        self.searchString = searchString
    }
    private enum EndPoint {
        case search
        case other
        var identifier: String {
            switch self {
                case .search:
                    return "search"
                case .other:
                    return "other"
            }
        }
    }
    var headers: HTTPHeaders {
        return ["Authorization": "rGXW2WWl0xOYm1ahExulb723HI2I9AKwJ6gmt5k1s1WmeyhZ0cXoLFqs"]
    }
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        // MARK: - Disabling cache bcz its showing same Response always.
        //        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .notAllowed)
        })
        let interceptor = APIRetry()
        return Session(
            configuration: configuration,
            interceptor: interceptor,
            cachedResponseHandler: nil)
    }()
    private func makeUrl(endPoint: EndPoint) -> String {
        return baseURL + endPoint.identifier
    }
}
extension APIClient {
    func callSearch(
        page: Int,
        perPage: Int,
        completion: @escaping (SearchResponse?, Error?) -> Void
    ) {
        let parameters = [
            "query": searchString,
            "page": page,
            "per_page": perPage
        ] as [String : Any]
        sessionManager.request(
            makeUrl(endPoint: .search),
            method: .get,
            parameters: parameters,
            encoding: URLEncoding(destination: .queryString),
            headers: headers
        ).response { response in
            guard response.error == nil else {
                completion(nil, response.error)
                return
            }
            do {
                let searchResponse = try JSONDecoder()
                    .decode(SearchResponse.self, from: response.data ?? Data())
                completion(searchResponse, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
