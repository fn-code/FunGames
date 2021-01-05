//
//  BerandaViewController.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/11/20.
//

import UIKit
import SDWebImage
import FunGamesCore
import Genre
import Game
import RxSwift

class HomeViewController: UIViewController {
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
  
  private var games: [GameDomainModel]?
  private var favorites: [FavoriteDomainModel]?
  
  let disposeBag = DisposeBag()
  let titleLogo: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "logo")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var collectionView: UICollectionView = {
    let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
    collectionView.backgroundColor = UIColor.white
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "section-header")
    collectionView.register(HomeGenreCollectionViewCell.self, forCellWithReuseIdentifier: "genre-cell")
    collectionView.register(HomeFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "favorite-cell")
    collectionView.register(HomePopularCollectionView.self, forCellWithReuseIdentifier: "popular-cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  init(presenter: GamePresenter) {
    self.gamePresenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setNavigationView()
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ])
    fetchData()
  }
  
  private func fetchData() {
    gamePresenter.getAllFavorite()
    gamePresenter.favorites
      .observeOn(MainScheduler.asyncInstance)
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .subscribe(onNext: { [weak self] _ in
        let gameResponse = self?.gamePresenter.favorites.value
        self?.favorites = gameResponse
        self?.collectionView.reloadData()
      })
      .disposed(by: disposeBag)
    
    gamePresenter.getHomePopular()
    gamePresenter.gamesPopular
      .observeOn(MainScheduler.asyncInstance)
      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .subscribe(onNext: { [weak self] _ in
        let gameResponse = self?.gamePresenter.gamesPopular.value
        self?.games = gameResponse
        self?.collectionView.reloadData()
      })
      .disposed(by: disposeBag)
  }
  
  func setNavigationView() {
    navigationItem.titleView = titleLogo
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  func makeLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout {(
      section: Int,
      environment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? in
      if HomeViewSections.Gets.favoriteView.section == section {
        return LayoutBuilder.buildHomeHorizontalSectionLayout(
          size: NSCollectionLayoutSize(widthDimension: .absolute(320), heightDimension: .absolute(234)))
      } else {
        return LayoutBuilder.buildTableSectionLayout()
      }
    }
    return layout
  }
  
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if HomeViewSections.Gets.favoriteView.section == section {
      return favorites?.count ?? 0
    }
    if HomeViewSections.Gets.popularView.section == section {
      return games?.count ?? 0
    }
    
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if HomeViewSections.Gets.favoriteView.section == indexPath.section {
      return CellBuilder.getHomeFavoriteCell(collectionView: collectionView, indexPath: indexPath, favorite: favorites![indexPath.row])
    }
    
    if HomeViewSections.Gets.popularView.section == indexPath.section {
      return CellBuilder.getHomePopularCell(collectionView: collectionView, indexPath: indexPath, game: games![indexPath.row])
    }
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let headerView = collectionView
            .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "section-header", for: indexPath) as? SectionHeader else {
      fatalError("Could not dequeue SectionHeader")
    }
    
    if HomeViewSections.Gets.popularView.section == indexPath.section {
      headerView.titleLabel.text = "popular_title".localized(identifier: "com.funproject.Fun-Games")
      headerView.subtitleLabel.text = "popular_subtitle".localized(identifier: "com.funproject.Fun-Games")
      headerView.isHidden = false
      headerView.viewButton.isHidden = true
      headerView.subtitleLabel.isHidden = false
    } else if HomeViewSections.Gets.favoriteView.section == indexPath.section {
      headerView.titleLabel.text = "favorite_title".localized(identifier: "com.funproject.Fun-Games")
      headerView.subtitleLabel.isHidden = true
      headerView.isHidden = false
      headerView.viewButton.isHidden = true
    } else {
      headerView.isHidden = true
    }
    return headerView
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if HomeViewSections.Gets.popularView.section == indexPath.section {
      let game = games![indexPath.row]
      self.navigationController?.pushViewController(HomeRouter().makeDetail(presenter: gamePresenter, id: game.id), animated: true)
    } else if HomeViewSections.Gets.favoriteView.section == indexPath.section {
      let favorite = favorites![indexPath.row]
      self.navigationController?.pushViewController(HomeRouter().makeDetail(presenter: gamePresenter, id: Int(favorite.id ?? 0)), animated: true)
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
}
