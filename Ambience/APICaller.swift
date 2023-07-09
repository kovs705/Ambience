//
//  APICaller.swift
//  Ambience
//
//  Created by Kovs on 01.07.2023.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Web {
        static let accessKey: String = "ThgR5z9J9aWH2GK2dWuMf9A9Ei3JZT8ygBCGwQmcGXI"
        static let baseURL: String   = "https://api.unsplash.com"
        static let searchURL: String = "/search/photos?query="
    }
    
    func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        
        guard let url = url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(Web.accessKey)",
                         forHTTPHeaderField: "Authorization")
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        
        completion(request)
    }
    
    func getPhotosFromUnsplash(with query: String!, completion: @escaping (Result<[ImageResult], Error>) -> Void) {
        createRequest(with: URL(string: Web.baseURL + Web.searchURL + query), type: .get) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(Results.self, from: data)
                    completion(.success(results.results))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
}
