//
//  ViewController.swift
//  Fun Games
//
//  Created by Ludin Nento on 13/11/20.
//

import UIKit
import SDWebImage
import RxSwift
import Game
import FunGamesCore

class DetailGameViewController: UIViewController {
  let disposeBag = DisposeBag()
  typealias DetailPresenter = GetGamePresenter<
    FavoriteDomainModel,
    FavoriteDomainModel,
    GameDomainModel,
    GameInteractor<
      FavoriteDomainModel,
      FavoriteDomainModel,
      GameDomainModel,
      GetGamesRepository<GameFavoriteLocalDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  var presenter: DetailPresenter!
  
  var game: GameDomainModel?
  var gameId: Int
  var isFavorited = false
  let scrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let mainImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleToFill
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let ratingLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 14)
    view.textColor = UIColor(named: "ratingColor")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let startIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "star")
    view.widthAnchor.constraint(equalToConstant: 14).isActive = true
    view.heightAnchor.constraint(equalToConstant: 14).isActive = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let reviewerLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 14)
    view.textColor = .darkText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let genreLabel: UILabel = {
    let view = PaddingLabel()
    view.padding(4, 4, 8, 8)
    view.font = UIFont.boldSystemFont(ofSize: 12)
    view.textColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    view.layer.cornerRadius = 6
    view.clipsToBounds = true
    view.adjustsFontSizeToFitWidth = true
    view.textAlignment = .center
    view.backgroundColor = .systemBlue
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let ratingGenreStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .horizontal
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let titleLabel: UILabel = {
    let view = UILabel()
    view.numberOfLines = 3
    view.font = UIFont.boldSystemFont(ofSize: 17)
    view.textColor = .darkText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let releasedLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 14)
    view.textColor = .darkGray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let playTimeLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 14)
    view.text = "Playtime"
    view.textColor = .gray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let playTimeCountLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 17)
    view.textColor = .darkText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let playTimeIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "play")
    view.widthAnchor.constraint(equalToConstant: 17).isActive = true
    view.heightAnchor.constraint(equalToConstant: 24).isActive = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let titleDescAndPlaytimeView: UIStackView = {
    let view = UIStackView()
    view.axis = .horizontal
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let platformMainLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.boldSystemFont(ofSize: 14)
    view.text = "Platforms"
    view.textColor = .darkText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let mainView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let platformContenView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let menuFavorite: UIButton = {
    let view = UIButton()
    view.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
    return view
  }()
  
  let mainLoader: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.style = .medium
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  init(presenter: DetailPresenter, id: Int) {
    self.presenter = presenter
    self.gameId = id
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "game_detail_title".localized(identifier: "com.funproject.Fun-Games")
    view.backgroundColor = .systemBackground
    view.addSubview(scrollView)
    fetchDetailGame()
    mainLoader.isHidden = false
    
    view.addSubview(mainLoader)
    view.addSubview(scrollView)
    
    mainLoader.startAnimating()
    mainLoader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    mainLoader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0,
                      left: view.safeAreaLayoutGuide.leadingAnchor, paddingLeft: 0, right: view.safeAreaLayoutGuide.trailingAnchor, paddingRight: 0,
                      width: 0, height: 0)
  }
  
  private func fetchDetailGame() {
    presenter.getGame(id: gameId)
    presenter.game
      .observeOn(MainScheduler.asyncInstance)
      .subscribe( onNext: { [weak self] result in
        self?.mainLoader.stopAnimating()
        self?.mainLoader.isHidden = true
        self?.game = result
        self?.setGameDetail(game: result)
      })
  }
  
  private func setGameDetail(game: GameDomainModel) {
    setNavigatioBarItem(game: game)
    mainView.addSubview(mainImageView)
    mainView.addSubview(ratingGenreStackView)
    mainView.addSubview(titleDescAndPlaytimeView)
    mainView.addSubview(platformMainLabel)
    mainView.addSubview(platformContenView)
    scrollView.addSubview(mainView)
    setMainImage(game: game)
    setRatingGenreView(game: game)
    setTitleDescAndPlaytimeView(game: game)
    setPlatformMainLabel()
    setPlatformsView(game: game)
    
    mainView.layoutIfNeeded()
    mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
  }
  private func setPlatformMainLabel() {
    platformMainLabel.topAnchor.constraint(equalTo: titleDescAndPlaytimeView.bottomAnchor, constant: 12).isActive = true
    platformMainLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 17).isActive = true
    platformMainLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -17).isActive = true
  }
  
  private func setMainImage(game: GameDomainModel) {
    mainView.addSubview(mainImageView)
    if let images = game.backgroundImage, !images.isEmpty {
      mainImageView.sd_setImage(with: URL(string: images)!, completed: nil)
    } else {
      mainImageView.image = UIImage(named: "no_photo")
    }
    mainImageView.layoutIfNeeded()
    mainImageView.heightAnchor.constraint(equalToConstant: 258).isActive = true
    mainImageView.widthAnchor.constraint(equalTo: mainView.widthAnchor).isActive = true
    mainImageView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
    mainImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
    mainImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
  }
  
  private func setPlatformsView(game: GameDomainModel) {
    let platform = game.platforms ?? []
    var gamePlatform = [UIStackView]()
    for itemPlatform in 0..<platform.count {
      let require = platform[itemPlatform].requirementsEn ?? nil
      gamePlatform.append(
        GamePlatformView(name: platform[itemPlatform].platform.name,
                         released: platform[itemPlatform].releasedAt ?? "-",
                         requirment: require))
      platformContenView.addArrangedSubview(gamePlatform[itemPlatform])
    }
    platformContenView.spacing = 16
    platformContenView.topAnchor.constraint(equalTo: platformMainLabel.bottomAnchor, constant: 8).isActive = true
    platformContenView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32).isActive = true
    platformContenView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32).isActive = true
    platformContenView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
  }
  
  private func setTitleDescAndPlaytimeView(game: GameDomainModel) {
    let playViewHor = UIStackView()
    let playViewVer = UIStackView()
    let titleDescView = UIStackView()
    let mainPlaytime = UIView()
    
    mainPlaytime.translatesAutoresizingMaskIntoConstraints = false
    playViewHor.spacing = 6
    playViewHor.axis = .horizontal
    playViewHor.distribution = .fill
    playViewHor.alignment = .fill
    playViewHor.translatesAutoresizingMaskIntoConstraints = false
    playViewHor.addArrangedSubview(playTimeIcon)
    playViewHor.addArrangedSubview(playTimeCountLabel)
    playViewVer.spacing = 4
    playViewVer.axis = .vertical
    playViewVer.distribution = .fill
    playViewVer.alignment = .fill
    playViewVer.translatesAutoresizingMaskIntoConstraints = false
    playViewVer.addArrangedSubview(playTimeLabel)
    playViewVer.addArrangedSubview(playViewHor)
    mainPlaytime.addSubview(playViewVer)
    playViewVer.trailingAnchor.constraint(equalTo: mainPlaytime.trailingAnchor, constant: 0).isActive = true
    
    titleDescView.spacing = 4
    titleDescView.axis = .vertical
    titleDescView.distribution = .fill
    titleDescView.alignment = .fill
    titleDescView.translatesAutoresizingMaskIntoConstraints = false
    titleDescView.addArrangedSubview(titleLabel)
    titleDescView.addArrangedSubview(releasedLabel)
    titleDescAndPlaytimeView.addArrangedSubview(titleDescView)
    titleDescAndPlaytimeView.addArrangedSubview(mainPlaytime)
    titleDescView.topAnchor.constraint(equalTo: titleDescAndPlaytimeView.topAnchor, constant: 0)
      .isActive = true
    titleDescView.bottomAnchor.constraint(equalTo: titleDescAndPlaytimeView.bottomAnchor, constant: 0)
      .isActive = true
    titleDescView.leadingAnchor.constraint(equalTo: titleDescAndPlaytimeView.leadingAnchor, constant: 0)
      .isActive = true
    mainPlaytime.topAnchor.constraint(equalTo: titleDescAndPlaytimeView.topAnchor, constant: 0)
      .isActive = true
    mainPlaytime.bottomAnchor.constraint(equalTo: titleDescAndPlaytimeView.bottomAnchor, constant: 0).isActive = true
    mainPlaytime.trailingAnchor.constraint(equalTo: titleDescAndPlaytimeView.trailingAnchor, constant: 0)
      .isActive = true
    titleDescAndPlaytimeView.layoutIfNeeded()
    titleDescAndPlaytimeView.distribution = .fillEqually
    titleDescAndPlaytimeView.alignment = .fill
    titleDescAndPlaytimeView.isLayoutMarginsRelativeArrangement = true
    titleDescAndPlaytimeView.preservesSuperviewLayoutMargins = false
    titleDescAndPlaytimeView.insetsLayoutMarginsFromSafeArea = false
    titleDescAndPlaytimeView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16)
      .isActive = true
    titleDescAndPlaytimeView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
      .isActive = true
    titleDescAndPlaytimeView.topAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 20).isActive = true
    titleLabel.text = game.name
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: game.released ?? "") ?? Date()
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
    let released = dateFormatterPrint.string(from: date)
    
    releasedLabel.text = "\(released)"
    playTimeCountLabel.text = "\(game.playtime)"
  }
  private func setRatingGenreView(game: GameDomainModel) {
    ratingGenreStackView.addSubview(ratingLabel)
    ratingGenreStackView.addSubview(startIcon)
    ratingGenreStackView.addSubview(reviewerLabel)
    ratingGenreStackView.addSubview(genreLabel)
    ratingLabel.topAnchor.constraint(equalTo: ratingGenreStackView.topAnchor, constant: 0).isActive = true
    ratingLabel.bottomAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 0).isActive = true
    ratingLabel.leadingAnchor.constraint(equalTo: ratingGenreStackView.leadingAnchor, constant: 0).isActive = true
    startIcon.topAnchor.constraint(equalTo: ratingGenreStackView.topAnchor, constant: 0).isActive = true
    startIcon.bottomAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 0).isActive = true
    startIcon.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 6).isActive = true
    reviewerLabel.topAnchor.constraint(equalTo: ratingGenreStackView.topAnchor, constant: 0).isActive = true
    reviewerLabel.bottomAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 0).isActive = true
    reviewerLabel.leadingAnchor.constraint(equalTo: startIcon.trailingAnchor, constant: 8).isActive = true
    genreLabel.topAnchor.constraint(equalTo: ratingGenreStackView.topAnchor, constant: 0).isActive = true
    genreLabel.bottomAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 0).isActive = true
    genreLabel.trailingAnchor.constraint(equalTo: ratingGenreStackView.trailingAnchor, constant: 0).isActive = true
    ratingGenreStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 16).isActive = true
    ratingGenreStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16).isActive = true
    ratingGenreStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16).isActive = true
    ratingLabel.text = "\(game.rating)"
    reviewerLabel.text = "\(game.ratingsCount) Reviewer"
    guard let genres = game.genres else {
      return
    }
    genreLabel.text = "\(genres.isEmpty ? "-" : genres[0].name)"
  }
  
  private func setNavigatioBarItem(game: GameDomainModel) {
    let rightItemButtonEdit = UIBarButtonItem(customView: menuFavorite)
    rightItemButtonEdit.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
    rightItemButtonEdit.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
    self.menuFavorite.addTarget(self, action: #selector(self.addFavorite(_:)), for: .touchUpInside)
    navigationItem.rightBarButtonItem = rightItemButtonEdit
    changeFavoriteStar(game: game)
  }
  
  private func changeFavoriteStar(game: GameDomainModel) {
    presenter.getFavorite(id: gameId)
    presenter.favorite
      .asObservable()
      .observeOn(MainScheduler.asyncInstance)
      .subscribe(onNext: { [weak self] result in
        if result?.id != 0 {
          self?.menuFavorite.setImage(UIImage(named: "star"), for: .normal)
          self?.isFavorited = true
        } else {
          self?.isFavorited = false
          self?.menuFavorite.setImage(UIImage(named: "star_black"), for: .normal)
        }
      })
      .disposed(by: disposeBag)

    presenter.addFavoriteState
      .observeOn(MainScheduler.asyncInstance)
      .subscribe(onNext: { [weak self] result in
        if result {
          self?.menuFavorite.setImage(UIImage(named: "star"), for: .normal)
          let alert = UIAlertController(title: "alert_information_title".localized(identifier: "com.funproject.Fun-Games"),
                                        message: "alert_success_added_favorite".localized(identifier: "com.funproject.Fun-Games"),
                                        preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          })
          self?.isFavorited = true
          self?.present(alert, animated: true, completion: nil)
        }
      })
      .disposed(by: disposeBag)
    
    presenter.deleteFavoriteState
      .observeOn(MainScheduler.asyncInstance)
      .subscribe(onNext: { [weak self] result in
        if result {
          self?.menuFavorite.setImage(UIImage(named: "star_black"), for: .normal)
          self?.isFavorited = false
        }
      })
      .disposed(by: disposeBag)
  }
  
  @objc func addFavorite(_ sender: UIButton) {
    if isFavorited {
      let alert = UIAlertController(title: "alert_information_title".localized(identifier: "com.funproject.Fun-Games"),
                                    message: "alert_favorite_remove_message".localized(identifier: "com.funproject.Fun-Games"),
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "alert_back_btn".localized(identifier: "com.funproject.Fun-Games"), style: .cancel))
      alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
        if self.game?.id != nil {
          self.presenter.deleteFavorite(id: self.gameId)
        }
      })
      self.present(alert, animated: true, completion: nil)
    } else {
      guard let game = self.game else { return }
      let favoriteEntity = FavoriteDomainModel(
        id: Int64(game.id),
        name: game.name,
        released: game.released ?? "",
        rating: game.rating,
        ratingCount: Int64(game.ratingsCount),
        image: game.backgroundImage ?? ""
      )
      presenter.addFavorite(request: favoriteEntity)
    }

  }
}
