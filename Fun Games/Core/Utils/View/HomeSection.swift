//
//  HomeSection.swift
//  Fun Games
//
//  Created by Ludin Nento on 01/01/21.
//

import Foundation

protocol HomeViewSection {
  var section: Int { get }
}

enum HomeViewSections {
  enum Gets: HomeViewSection {
    
    case favoriteView
    case popularView
    
    public var section: Int {
      switch self {
      case .favoriteView: return 0
      case .popularView: return 1
      }
    }
  }
}
