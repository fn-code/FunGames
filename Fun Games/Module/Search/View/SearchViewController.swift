//
//  SearchViewController.swift
//  Fun Games
//
//  Created by Ludin Nento on 18/11/20.
//

import UIKit
import RxSwift
import FunGamesCore
import Game

class SearchViewController: UIViewController {
  
  typealias SearchPresenter = GetGamePresenter<
    FavoriteDomainModel,
    FavoriteDomainModel,
    GameDomainModel,
    GameInteractor<
      FavoriteDomainModel,
      FavoriteDomainModel,
      GameDomainModel,
      GetGamesRepository<GameFavoriteLocalDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  
  var presenter: SearchPresenter!
  let disposeBag = DisposeBag()
  
  var filterText: String = ""
  var games: [GameDomainModel] = []
  
  lazy var isLoaded = false
  var berandaController: PopularViewController?
  var isLoad = false
  var nextPage: Int = 1
  
  let searchTableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = 132
    tableView.register(GamesTableViewCell.self, forCellReuseIdentifier: "gamesCell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  let loader: UIActivityIndicatorView = {
    let indicatorView = UIActivityIndicatorView()
    indicatorView.style = .medium
    return indicatorView
  }()
  let mainLoader: UIActivityIndicatorView = {
    let indicatorView = UIActivityIndicatorView()
    indicatorView.style = .medium
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    return indicatorView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setTableView()
    view.addSubview(mainLoader)
    mainLoader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    mainLoader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
  }
  
  func setTableView() {
    searchTableView.isHidden = true
    searchTableView.delegate = self
    searchTableView.dataSource = self
    view.addSubview(searchTableView)
    searchTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  func filterGames(query: String, presenter: SearchPresenter, beranda: PopularViewController) {
    let escapedString = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    mainLoader.startAnimating()
    searchTableView.isHidden = true
    games = []
    filterText = escapedString
    self.presenter = presenter
    berandaController = beranda
    nextPage = 1
    fetchGamesData(page: nextPage, query: escapedString)
  }
  
  private func fetchGamesData(page: Int, query: String) {
    presenter.getAllGames(page: page, query: query, pageSize: 20)
    presenter.loadingState
      .observeOn(MainScheduler.asyncInstance)
      .filter({ $0 == false })
      .subscribe({ [weak self] _ in
        guard let gamesModel = self?.presenter.games.value else { return }
        if gamesModel.isEmpty {
          let alert = UIAlertController(
            title: "Perhatian",
            message: "Game yang dicari tidak ditemukan",
            preferredStyle: .alert
          )
          alert.addAction(UIAlertAction(title: "Kembali", style: .cancel, handler: nil))
          self?.present(alert, animated: true)
        }
        if page == 1 {
          self?.mainLoader.stopAnimating()
          self?.mainLoader.isHidden = true
        }
        self?.games.append(contentsOf: gamesModel)
        self?.isLoad = true
        self?.nextPage = page + 1
        self?.loader.stopAnimating()
        self?.loader.isHidden = true
        self?.searchTableView.isHidden = false
        self?.searchTableView.reloadData()
        self?.searchTableView.tableFooterView?.isHidden = true
      })
      .disposed(by: disposeBag)

    presenter.error
      .observeOn(MainScheduler.asyncInstance)
      .subscribe { [weak self] (res) in
        guard let error = res.element else { return }
        if !error.isEmpty {
            let alert = UIAlertController(
              title: "Information",
              message: "Failed fetching games data",
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
            self?.searchTableView.tableFooterView?.isHidden = true
          }
      }
      .disposed(by: disposeBag)
  }
  
  @objc func addFavorite(_ sender: UIButton) {
    let game = games[sender.tag]
    presenter.getFavorite(id: game.id)
    presenter.favoriteGetComplete
      .asSingle()
      .observeOn(MainScheduler.asyncInstance)
      .subscribe({ [weak self] _ in
        let favModel = self?.presenter.favorite.value
        if favModel?.id != 0 {
          let alert = UIAlertController(title: "Successful", message: "Game sudah menjadi favorite.", preferredStyle: .alert)
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
          self?.presenter.addFavorite(request: favoriteEntity)
        }
      })
      .disposed(by: disposeBag)
    
    presenter.addFavoriteState
      .observeOn(MainScheduler.asyncInstance)
      .subscribe { result in
        guard let isOk = result.element else { return }
        if isOk {
          let alert = UIAlertController(title: "Successful", message: "Berhasil menambahkan ke daftar favorite.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
          })
          self.present(alert, animated: true, completion: nil)
        }
      }
      .disposed(by: disposeBag)
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = searchTableView
        .dequeueReusableCell(withIdentifier: "gamesCell", for: indexPath) as? GamesTableViewCell {
      let game = games[indexPath.row]
      
      cell.name.text = game.name
      cell.released.text = "Released \(game.released ?? "")"
      cell.ratingLabel.text = "\(game.rating)"
      cell.reviewerLabel.text = "\(game.ratingsCount) Reviewer"
      cell.favoriteButton.addTarget(self, action: #selector(self.addFavorite(_:)), for: .touchUpInside)
      cell.favoriteButton.tag = indexPath.row
      if let images = game.backgroundImage, !images.isEmpty {
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
    let detailView = SearchRouter().makeDetail(presenter: presenter, id: game.id)
    self.berandaController?.navigationController?.pushViewController(detailView, animated: true)
  }
  
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
          width: self.searchTableView.bounds.width,
          height: CGFloat(44)
        )
        self.searchTableView.tableFooterView = self.loader
        self.searchTableView.tableFooterView?.isHidden = false
      }
      fetchGamesData(page: nextPage, query: filterText)
    }
  }
}
