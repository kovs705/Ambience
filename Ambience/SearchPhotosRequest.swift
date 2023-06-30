//
//  SearchPhotosRequest.swift
//  Ambience
//
//  Created by Kovs on 30.06.2023.
//

import Foundation

struct SearchPhotosRequest: DataRequest {
    
    var page: String
    var query: String
    
    var url: String {
        let baseURL = "https://api.unsplash.com"
        let path = "/search/photos?"
        return baseURL + path
        
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "page": page,
            "query": query
        ]
    }
    
    var method: HTTPMethod{
        .get
    }
    
    init(page: String, query: String) {
        self.page = page
        self.query = query
    }
    
    func decode(_ data: Data) throws -> [UnImage]? {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(UnImageModel.self, from: data)
        return response.results
    }
    
}
