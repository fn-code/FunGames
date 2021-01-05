//
//  FavoriteViewController.swift
//  Fun Games
//
//  Created by Ludin Nento on 23/11/20.
//

import UIKit
import RxSwift
import FunGamesCore
import Game

class FavoriteViewController: UIViewController {
  typealias FavoritePresenter = GetGamePresenter<
    FavoriteDomainModel,
    FavoriteDomainModel,
    GameDomainModel,
    GameInteractor<
      FavoriteDomainModel,
      FavoriteDomainModel,
      GameDomainModel,
      GetGamesRepository<GameFavoriteLocalDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  
  var favoritePresenter: FavoritePresenter!
  let disposeBag = DisposeBag()
  var games: [FavoriteDomainModel] = []
  
  let favoriteTableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = 132
    tableView.register(GamesTableViewFavoriteCell.self, forCellReuseIdentifier: "gamesFavoriteCell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  let mainLoader: UIActivityIndicatorView = {
    let indicatorView = UIActivityIndicatorView()
    indicatorView.style = .medium
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    return indicatorView
  }()
  
  init(presenter: FavoritePresenter) {
    favoritePresenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Favorite"
    navigationItem.title = "favorite_title".localized(identifier: "com.funproject.Fun-Games")
    view.backgroundColor = .systemBackground
    setTableView()
    view.addSubview(mainLoader)
    mainLoader.startAnimating()
    mainLoader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    mainLoader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    games = []
    fetchGamesData()
  }
  
  func setTableView() {
    favoriteTableView.isHidden = true
    favoriteTableView.delegate = self
    favoriteTableView.dataSource = self
    view.addSubview(favoriteTableView)
    favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  private func fetchGamesData() {
    favoritePresenter.getAllFavorite()
    favoritePresenter.loadingFavoritesState
      .observeOn(MainScheduler.asyncInstance)
      .subscribe(onNext: { [weak self] result in
        self?.games = []
        if !result {
          guard let favModel = self?.favoritePresenter.favorites.value else { return }
          if favModel.isEmpty {
            let alert = UIAlertController(
              title: "alert_information_title".localized(identifier: "com.funproject.Fun-Games"),
              message: "alert_favorite_empty_message".localized(identifier: "com.funproject.Fun-Games"),
              preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
              self?.navigationController?.popViewController(animated: true)
            })
            self?.present(alert, animated: true)
          }
          self?.games.append(contentsOf: favModel)
          self?.mainLoader.stopAnimating()
          self?.mainLoader.isHidden = true
          self?.favoriteTableView.isHidden = false
          self?.favoriteTableView.reloadData()
          self?.favoriteTableView.tableFooterView?.isHidden = true
        }
      })
      .disposed(by: disposeBag)
  }
  
  @objc func removeGameFavorite(_ sender: UIButton) {
    let game = games[sender.tag]
    if let gameID = Int(exactly: game.id ?? 0) {
      let alert = UIAlertController(title: "alert_information_title".localized(identifier: "com.funproject.Fun-Games"),
                                    message: "alert_favorite_remove_message".localized(identifier: "com.funproject.Fun-Games"),
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "alert_back_btn".localized(identifier: "com.funproject.Fun-Games"), style: .cancel))
      alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
        self.favoritePresenter.deleteFavorite(id: gameID)
      })
      self.present(alert, animated: true, completion: nil)
    }
    
    favoritePresenter.deleteFavoriteState
      .observeOn(MainScheduler.asyncInstance)
      .subscribe(onNext: { [weak self] result in
        if result {
          self?.mainLoader.startAnimating()
          self?.mainLoader.isHidden = false
          self?.fetchGamesData()
        }
      })
      .disposed(by: disposeBag)
    
  }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = favoriteTableView
        .dequeueReusableCell(withIdentifier: "gamesFavoriteCell", for: indexPath) as? GamesTableViewFavoriteCell {
      let game = games[indexPath.row]
      cell.name.text = game.name
      cell.released.text = "\(game.released ?? "")"
      cell.ratingLabel.text = "\(game.rating ?? 0)"
      cell.reviewerLabel.text = "\(game.ratingCount ?? 0) Reviewer"
      cell.favoriteButton.addTarget(self, action: #selector(self.removeGameFavorite(_:)), for: .touchUpInside)
      cell.favoriteButton.tag = indexPath.row
      if let images = game.image, !images.isEmpty {
        cell.gameImage.sd_setImage(with: URL(string: images)!, completed: nil)
      } else {
        cell.gameImage.image = UIImage(named: "no_photo")
      }
      
      if cell.accessoryView == nil {
        cell.accessoryView = UIActivityIndicatorView(style: .medium)
      }
      return cell
    } else {
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let game = games[indexPath.row]
    let detailView = FavoriteRouter().makeDetail(presenter: favoritePresenter, id: Int(game.id ?? 0))
    self.navigationController?.pushViewController(detailView, animated: true)
  }
  
}
