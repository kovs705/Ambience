//
//  ErrorResponse.swift
//  Ambience
//
//  Created by Kovs on 14.06.2023.
//

import Foundation

enum ErrorResponse: String {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    public var description: String {
        switch self {
        case .apiError: return "Ooops, there is something wrong with the api"
        case .invalidEndpoint: return "Ooops, there is something wrong with the endpoint"
        case .invalidResponse: return "Ooops, there is something wrong with the response"
        case .noData: return "Ooops, there is something wrong with the data"
        case .serializationError: return "Ooops, there is something wrong with the serialization process"
        }
    }
}
