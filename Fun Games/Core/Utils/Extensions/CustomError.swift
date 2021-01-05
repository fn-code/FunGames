//
//  CustomError.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

enum URLError: LocalizedError {
  case invalidResponse
  case addressUnreachable(URL)
  
  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    }
  }
}
