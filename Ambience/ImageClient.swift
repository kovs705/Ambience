//
//  ImageClient.swift
//  Ambience
//
//  Created by Kovs on 30.06.2023.
//

import UIKit

protocol ImageClientService {
    func downloadImage<Request: DataRequest>(request: Request) async throws -> UIImage?
    func setImage(from url: String, placeholderImage: UIImage?) async throws -> UIImage?
}

final class ImageClient {
    let service: NetworkService = DefaultNetworkService()
    static let shared = ImageClient(responseQueue: .main, session: URLSession.shared)
    
    private(set) var cachedImageForURL: [String: UIImage]
    let responseQueue: DispatchQueue?
    let session: URLSession
    
    init(responseQueue: DispatchQueue?, session: URLSession) {
        self.cachedImageForURL = [:]
        self.responseQueue = responseQueue
        self.session = session
    }
    
    func clearCache() {
        cachedImageForURL.removeAll()
    }
    
    private func dispatchImage(image: UIImage? = nil, error: Error? = nil, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let responseQueue = responseQueue else {
            completion(image, error)
            return
        }
        
        responseQueue.async {
            completion(image, error)
        }
    }
}

extension ImageClient: ImageClientService {
    func downloadImage<Request: DataRequest>(request: Request) async throws -> UIImage? {
        do {
            let response = try await service.request(request)
            guard let image: UIImage = response as? UIImage else {
                return nil
            }
            return image
        } catch {
            throw error
        }
    }
    
    func setImage(from url: String,
                  placeholderImage: UIImage?) async throws -> UIImage? {
        let request = ImageRequest(url: url)
        
        if let cacheImage = cachedImageForURL[url] {
            return cacheImage
        } else {
            do {
                if let image = try await downloadImage(request: request) {
                    cachedImageForURL[url] = image
                    return cachedImageForURL[url]
                } else {
                    return placeholderImage
                }
            } catch {
                throw error
            }
        }
    }
}

