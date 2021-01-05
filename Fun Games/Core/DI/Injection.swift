//
//  Injection.swift
//  Fun Games
//
//  Created by Ludin Nento on 15/12/20.
//

import Foundation
import CoreData
import FunGamesCore
import Game
import UIKit

final class Injection: NSObject {
  
  func provideGames<U: GameUseCase> () -> U
  where
    U.RequestFavorite == FavoriteDomainModel,
    U.ResponseFavorite == FavoriteDomainModel,
    U.ResponseGame == GameDomainModel {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return U.self as! U
    }
    
    let remote = GetGamesRemoteDataSource(enpointGame: Endpoints.Gets.games.url)
    let local = GameFavoriteLocalDataSource(presententContainer: appDelegate.persisContainer!)
    let mapper = GameTransformer()
    
    let repository = GetGamesRepository(localeDataSource: local, remoteDataSource: remote, mapper: mapper)
  
    return GameInteractor(repository: repository) as! U
  }
}
