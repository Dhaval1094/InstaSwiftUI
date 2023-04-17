//
//  APIRetry.swift
//  InstaSwiftUI
//
//  Created by Dhaval Trivedi on 15/04/23.
//

import Foundation
import Alamofire
class APIRetry: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let urlRequest = urlRequest
        completion(.success(urlRequest))
    }
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        debugPrint("API retry Called..")
        let response = request.task?.response as? HTTPURLResponse
        // Retry for 5xx status codes
        if let statusCode = response?.statusCode,
           (500...599).contains(statusCode),
           request.retryCount < 0 {
            completion(.retryWithDelay(5))
        } else {
            return completion(.doNotRetry)
        }
    }
}
