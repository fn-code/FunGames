//
//  SceneDelegate.swift
//  Fun Games
//
//  Created by Ludin Nento on 13/11/20.
//

import UIKit
import Common
import FunGamesCore
import Game

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let winScene = (scene as? UIWindowScene) else { return }
    if !ProfileModel.stateLogin {
      ProfileModel.stateLogin = true
      ProfileModel.name = "Khairudin Firdaus Nento"
      ProfileModel.country = "Indonesia"
      ProfileModel.email = "ludin.nento.app@gmail.com"
      ProfileModel.facebookUsername = "ludyn.nento"
      ProfileModel.githubUsername = "fn-code"
    }
    
    let gameUseCase: GameInteractor<
        FavoriteDomainModel,
        FavoriteDomainModel,
        GameDomainModel,
        GetGamesRepository<
            GameFavoriteLocalDataSource,
            GetGamesRemoteDataSource,
            GameTransformer>
    > = Injection.init().provideGames()
    
    let gamePresenter = GetGamePresenter(useCase: gameUseCase)
    
    let homeView = UINavigationController(rootViewController: HomeViewController(presenter: gamePresenter))
    let popularView = UINavigationController(rootViewController: PopularViewController(presenter: gamePresenter))
    let favoriteView = UINavigationController(rootViewController: FavoriteViewController(presenter: gamePresenter))
    let profileView = UINavigationController(rootViewController: ProfileViewController())
    
    homeView.title = "home_tab_bottom".localized(identifier: "com.funproject.Fun-Games")
    popularView.title = "popular_tab_bottom".localized(identifier: "com.funproject.Fun-Games")
    favoriteView.title = "favorite_tab_bottom".localized(identifier: "com.funproject.Fun-Games")
    profileView.title = "profile_tab_bottom".localized(identifier: "com.funproject.Fun-Games")
    
    let tabBarVC = UITabBarController()
    tabBarVC.setViewControllers([homeView, popularView, favoriteView, profileView], animated: false)
    guard let items =  tabBarVC.tabBar.items else {
      return
    }
    
    let images = ["house", "gamecontroller", "star.circle", "person.crop.circle"]
    for index in 0..<items.count {
      items[index].image = UIImage(systemName: images[index])
    }
    tabBarVC.modalPresentationStyle = .fullScreen
  
    window = UIWindow(windowScene: winScene)
    window?.rootViewController = tabBarVC
    window?.makeKeyAndVisible()
  }
  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }
  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }
  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }
  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }
  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }
}
