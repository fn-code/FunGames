//
//  Popular Router.swift
//  Fun Games
//
//  Created by Ludin Nento on 30/12/20.
//

import Foundation
import FunGamesCore
import Game

class PopularRouter {
  typealias GamePresenter = GetGamePresenter<
    FavoriteDomainModel,
    FavoriteDomainModel,
    GameDomainModel,
    GameInteractor<
      FavoriteDomainModel,
      FavoriteDomainModel,
      GameDomainModel,
      GetGamesRepository<GameFavoriteLocalDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  
  func makeDetail(presenter: GamePresenter, id: Int) -> DetailGameViewController {
    let detailView = DetailGameViewController(presenter: presenter, id: id)
    return detailView
  }
}
