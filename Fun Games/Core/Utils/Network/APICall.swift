//
//  APICall.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case games
    case genres
    
    public var url: String {
      switch self {
      case .games: return "\(API.baseUrl)games"
      case .genres: return "\(API.baseUrl)genres"
      }
    }
  }
  
}
