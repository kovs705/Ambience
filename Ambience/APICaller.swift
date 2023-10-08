//
//  APICaller.swift
//  Ambience
//
//  Created by Kovs on 01.07.2023.
//

import Foundation

class APICaller {
    static let shared = APICaller()

    init() {}

    struct Web {
        static let accessKey: String = "ThgR5z9J9aWH2GK2dWuMf9A9Ei3JZT8ygBCGwQmcGXI"
        static let baseURL: String = "https://api.unsplash.com"
        static let searchURL: String = "/search/photos?query="
    }

    func createRequestAndFetchPhotos(with query: String!, completion: @escaping (Result<[ImageResult], Error>) -> Void) {
        guard let changedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        guard let url = URL(string: "https://api.unsplash.com" + "/search/photos?query=" + "\(changedQuery)") else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Client-ID \(Web.accessKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(Results.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

}
