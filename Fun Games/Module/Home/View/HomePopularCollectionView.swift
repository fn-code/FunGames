//
//  HomePopularCollectionView.swift
//  Fun Games
//
//  Created by Ludin Nento on 01/01/21.
//

import UIKit

class HomePopularCollectionView: UICollectionViewCell {
  
  let container: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let name: UILabel = {
      let view = UILabel()
      view.numberOfLines = 1
      view.font = UIFont.boldSystemFont(ofSize: 16)
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  let released: UILabel = {
      let view = UILabel()
      view.font = UIFont.systemFont(ofSize: 12)
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  let gameImage: UIImageView = {
      let view = UIImageView()
      view.contentMode = .scaleAspectFill
      view.layer.cornerRadius = 16
      view.clipsToBounds = true
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  let ratingLabel: UILabel = {
      let view = UILabel()
      view.font = UIFont.systemFont(ofSize: 12)
      view.textColor = UIColor(named: "ratingColor")
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  let startIcon: UIImageView = {
      let view = UIImageView()
      view.image = UIImage(named: "star")
      view.widthAnchor.constraint(equalToConstant: 12).isActive = true
      view.heightAnchor.constraint(equalToConstant: 12).isActive = true
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  let reviewerLabel: UILabel = {
      let view = UILabel()
      view.font = UIFont.systemFont(ofSize: 12)
      view.textColor = .darkText
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  let ratingGenreStackView: UIStackView = {
      let view = UIStackView()
      view.axis = .horizontal
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(container)
    container.addSubview(name)
    container.addSubview(released)
    container.addSubview(ratingGenreStackView)
    container.addSubview(gameImage)
    
    ratingGenreStackView.addSubview(ratingLabel)
    ratingGenreStackView.addSubview(startIcon)
    ratingGenreStackView.addSubview(reviewerLabel)
    
    container.anchor(top: contentView.topAnchor, paddingTop: 0, bottom: contentView.bottomAnchor, paddingBottom: 0,
                     left: contentView.leadingAnchor, paddingLeft: 0, right: contentView.trailingAnchor, paddingRight: 0,
                     width: 0, height: 0)
    
    gameImage.heightAnchor.constraint(equalToConstant: 76.0).isActive = true
    gameImage.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    gameImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0).isActive = true
    
    name.anchor(top: container.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0,
                left: gameImage.trailingAnchor, paddingLeft: 8, right: container.trailingAnchor, paddingRight: 0,
                width: 0, height: 0)
    
    released.anchor(top: name.bottomAnchor, paddingTop: 4, bottom: nil, paddingBottom: 0,
                    left: gameImage.trailingAnchor, paddingLeft: 8, right: container.trailingAnchor, paddingRight: 0,
                    width: 0, height: 0)
    
    ratingLabel.anchor(top: ratingGenreStackView.topAnchor, paddingTop: 0, bottom: ratingGenreStackView.bottomAnchor, paddingBottom: 0,
                       left: ratingGenreStackView.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0,
                       width: 0, height: 0)
    
    startIcon.anchor(top: ratingGenreStackView.topAnchor, paddingTop: 0, bottom: ratingGenreStackView.bottomAnchor, paddingBottom: 0,
                     left: ratingLabel.trailingAnchor, paddingLeft: 6, right: nil, paddingRight: 0,
                     width: 0, height: 0)
    
    reviewerLabel.anchor(top: ratingGenreStackView.topAnchor, paddingTop: 0, bottom: ratingGenreStackView.bottomAnchor, paddingBottom: 0,
                         left: startIcon.trailingAnchor, paddingLeft: 8, right: nil, paddingRight: 0,
                         width: 0, height: 0)
    
    ratingGenreStackView.anchor(top: released.bottomAnchor, paddingTop: 6, bottom: nil, paddingBottom: 0,
                                left: gameImage.trailingAnchor, paddingLeft: 8, right: container.trailingAnchor, paddingRight: 0,
                                width: 0, height: 0)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
