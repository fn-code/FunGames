//
//  PopularViewController.swift
//  Fun Games
//
//  Created by Ludin Nento on 30/12/20.
//

import UIKit
import RxSwift
import FunGamesCore
import Game

class PopularViewController: UIViewController {
  
  typealias GamePresenter = GetGamePresenter<
    FavoriteDomainModel,
    FavoriteDomainModel,
    GameDomainModel,
    GameInteractor<
      FavoriteDomainModel,
      FavoriteDomainModel,
      GameDomainModel,
      GetGamesRepository<GameFavoriteLocalDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  
  var gamePresenter: GamePresenter!
  let disposeBag = DisposeBag()
  var isLoad = false
  var nextPage: Int = 1
  var games: [GameDomainModel] = []
  
  var searchController: UISearchController = UISearchController(searchResultsController: SearchViewController())
  
  let tableView: UITableView = {
    let view = UITableView()
    view.rowHeight = 132
    view.register(GamesTableViewCell.self, forCellReuseIdentifier: "gamesCell")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let loader: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.style = .medium
    return view
  }()
  
  let mainLoader: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.style = .medium
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  init(presenter: GamePresenter) {
    gamePresenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.isHidden = true
    tableView.delegate = self
    tableView.dataSource = self
    view.backgroundColor = .systemBackground
    
    setNavigationView()
    setTableView()
    view.addSubview(mainLoader)
    mainLoader.startAnimating()
    mainLoader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    mainLoader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true

    fetchGamesData(page: nextPage)
  }
  
  private func fetchGamesData(page: Int) {
    gamePresenter.getAllGames(page: page, query: "", pageSize: 20)
    gamePresenter.loadingState
      .observeOn(MainScheduler.asyncInstance)
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .filter { $0 == false }
      .subscribe { [weak self] _ in
        if page == 1 {
          self?.mainLoader.stopAnimating()
          self?.mainLoader.isHidden = true
        }
        guard let gameModel = self?.gamePresenter.games.value else { return }
        self?.games.append(contentsOf: gameModel)
        self?.nextPage = page + 1
        self?.loader.stopAnimating()
        self?.loader.isHidden = true
        self?.tableView.isHidden = false
        self?.tableView.reloadData()
        self?.tableView.tableFooterView?.isHidden = true
        self?.isLoad = true
      }
      .disposed(by: disposeBag)

    gamePresenter.error
      .observeOn(MainScheduler.asyncInstance)
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .subscribe { [weak self] (res) in
        guard let error = res.element else { return }
        if !error.isEmpty {
          let alert = UIAlertController(
            title: "alert_error_fetching_title".localized(identifier: "com.funproject.Fun-Games"),
            message: "alert_error_fetching_message".localized(identifier: "com.funproject.Fun-Games"),
            preferredStyle: .alert
          )
          alert.addAction(UIAlertAction(title: "Okey", style: .cancel, handler: nil))
          self?.present(alert, animated: true)
          if page == 1 {
            self?.mainLoader.stopAnimating()
            self?.mainLoader.isHidden = true
          }
          self?.loader.stopAnimating()
          self?.loader.isHidden = true
        }
      }
      .disposed(by: disposeBag)
  }
  
  func setTableView() {
    view.addSubview(tableView)
    tableView.anchor(
      top: view.topAnchor, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0,
      left: view.leadingAnchor, paddingLeft: 0, right: view.trailingAnchor, paddingRight: 0,
      width: 0, height: 0
    )
  }
  
  func setNavigationView() {
    navigationItem.title = "popular_title".localized(identifier: "com.funproject.Fun-Games")
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationItem.searchController = searchController
    
    searchController.searchBar.placeholder = "popular_search".localized(identifier: "com.funproject.Fun-Games")
    searchController.obscuresBackgroundDuringPresentation = true
    searchController.automaticallyShowsSearchResultsController = true
    searchController.searchBar.rx.text
      .orEmpty
      .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
      .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
      .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
      .subscribe(onNext: { [weak self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
        let resultController = self?.searchController.searchResultsController as? SearchViewController
        resultController?.filterGames(query: query, presenter: (self?.gamePresenter)!, beranda: self!)
      })
      .disposed(by: disposeBag)
  }
  
  @objc func addFavorite(_ sender: UIButton) {
    let game = games[sender.tag]
    gamePresenter.getFavorite(id: game.id)
    gamePresenter.favoriteGetComplete
      .asSingle()
      .observeOn(MainScheduler.asyncInstance)
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .subscribe({ [weak self] _ in
        let favModel = self?.gamePresenter.favorite.value
        if favModel?.id != 0 {
          let alert = UIAlertController(title: "alert_success_title".localized(identifier: "com.funproject.Fun-Games"),
                                        message: "alert_already_favorite".localized(identifier: "com.funproject.Fun-Games"),
                                        preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self?.navigationController?.popViewController(animated: true)
          })
          self?.present(alert, animated: true, completion: nil)
        } else {
          let favoriteEntity = FavoriteDomainModel(
            id: Int64(game.id),
            name: game.name,
            released: game.released ?? "",
            rating: game.rating,
            ratingCount: Int64(game.ratingsCount),
            image: game.backgroundImage ?? ""
          )
          self?.gamePresenter.addFavorite(request: favoriteEntity)
        }
      })
      .disposed(by: disposeBag)
    
    gamePresenter.addFavoriteState
      .observeOn(MainScheduler.asyncInstance)
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .subscribe(onNext: { [weak self] result in
        if result {
          let alert = UIAlertController(title: "alert_success_title".localized(identifier: "com.funproject.Fun-Games"),
                                        message: "alert_success_added_favorite".localized(identifier: "com.funproject.Fun-Games"),
                                        preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self?.navigationController?.popViewController(animated: true)
          })
          self?.present(alert, animated: true, completion: nil)
        }
      })
      .disposed(by: disposeBag)
  }
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "gamesCell", for: indexPath)
        as? GamesTableViewCell {
      let game = games[indexPath.row]
      
      cell.name.text = game.name
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
      dateFormatter.dateFormat = "yyyy-MM-dd"
      
      let date = dateFormatter.date(from: (game.released ?? "")) ?? Date()
      let dateFormatterPrint = DateFormatter()
      dateFormatterPrint.dateFormat = "MMM dd,yyyy"
      let released = dateFormatterPrint.string(from: date)
      
      cell.released.text = "\(released)"
      cell.ratingLabel.text = "\(game.rating)"
      cell.reviewerLabel.text = "\(game.ratingsCount) Reviewer"
      cell.favoriteButton.addTarget(self, action: #selector(self.addFavorite(_:)), for: .touchUpInside)
      cell.favoriteButton.tag = indexPath.row
      
      if let images = game.backgroundImage, !images.isEmpty {
        cell.gameImage.sd_setImage(with: URL(string: images), completed: nil)
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
    let detailViewControler = PopularRouter().makeDetail(presenter: gamePresenter, id: game.id)
    self.navigationController?.pushViewController(detailViewControler, animated: true)
  }
}

extension PopularViewController: UISearchControllerDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHight = scrollView.contentSize.height
    
    if (offsetY > contentHight - scrollView.frame.height) && isLoad {
      isLoad = false
      DispatchQueue.main.async {
        self.loader.isHidden = false
        self.loader.startAnimating()
        self.loader.frame = CGRect(
          x: CGFloat(0),
          y: CGFloat(0),
          width: self.tableView.bounds.width,
          height: CGFloat(44))
        self.tableView.tableFooterView = self.loader
        self.tableView.tableFooterView?.isHidden = false
      }
      fetchGamesData(page: nextPage)
    }
  }
  
}
