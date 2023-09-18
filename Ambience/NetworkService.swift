//
//  NetworkService.swift
//  Ambience
//
//  Created by Kovs on 14.06.2023.
//

import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request) async throws -> Request.Response
}

final class DefaultNetworkService: NetworkService {
    func request<Request: DataRequest>(_ request: Request) async throws -> Request.Response {
        guard var urlComponent = URLComponents(string: request.url) else {
            throw NSError(
                domain: ErrorResponse.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.queryItems.forEach { key, value in
            let urlQueryItem = URLQueryItem(name: key, value: value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            throw NSError(
                domain: ErrorResponse.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            print("response is \(response)")
            throw NSError()
        }
        
        return try request.decode(data)
    }
}
