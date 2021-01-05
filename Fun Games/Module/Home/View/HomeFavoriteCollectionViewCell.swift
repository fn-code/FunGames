//
//  HomeFavoriteCollectionViewCell.swift
//  Fun Games
//
//  Created by Ludin Nento on 31/12/20.
//

import UIKit

class HomeFavoriteCollectionViewCell: UICollectionViewCell {
  
  let container: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.cornerRadius = 16
    view.backgroundColor = .systemBackground
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let containerReleasedReview: UIStackView = {
      let view = UIStackView()
    view.axis = .horizontal
    view.distribution = .fill
    view.alignment = .fill
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let containerTitleRating: UIStackView = {
      let view = UIStackView()
    view.axis = .horizontal
    view.distribution = .fillProportionally
    view.alignment = .fill
    view.spacing = 60
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let containerRating: UIView = {
      let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let containerRatingStakView: UIStackView = {
      let view = UIStackView()
    view.distribution = .fillProportionally
    view.alignment = .fill
    view.backgroundColor = .brown
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let titleLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "Title"
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .black
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let releaseDateLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "Released Mar 17, 2020"
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .black
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let reviewsLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "12000 Reviews"
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .black
    label.textAlignment = .right
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let ratingLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "14.0"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .systemOrange
    label.textAlignment = .right
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let startIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "star")
    view.widthAnchor.constraint(equalToConstant: 14).isActive = true
    view.heightAnchor.constraint(equalToConstant: 14).isActive = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let genreImage: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "genre")
    imgView.contentMode = .scaleAspectFill
    imgView.layer.cornerRadius = 16
    imgView.clipsToBounds = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(container)
    container.addSubview(genreImage)
    
    containerRating.addSubview(startIcon)
    containerRating.addSubview(ratingLabel)
    containerRatingStakView.addArrangedSubview(containerRating)
    
    containerTitleRating.addArrangedSubview(titleLabel)
    containerTitleRating.addArrangedSubview(containerRatingStakView)
    container.addSubview(containerTitleRating)
    
    containerReleasedReview.addArrangedSubview(releaseDateLabel)
    containerReleasedReview.addArrangedSubview(reviewsLabel)
    container.addSubview(containerReleasedReview)
    
    container.anchor(top: contentView.topAnchor, paddingTop: 0, bottom: contentView.bottomAnchor, paddingBottom: 0,
                     left: contentView.leadingAnchor, paddingLeft: 0, right: contentView.trailingAnchor, paddingRight: 0,
                     width: 0, height: 0)
    
    genreImage.anchor(top: container.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0,
                      left: container.leadingAnchor, paddingLeft: 0, right: container.trailingAnchor, paddingRight: 0,
                      width: 0, height: 174)
    
    titleLabel.anchor(top: containerTitleRating.topAnchor, paddingTop: 0, bottom: containerTitleRating.bottomAnchor, paddingBottom: 0,
                      left: containerTitleRating.leadingAnchor, paddingLeft: 0, right: nil, paddingRight: 0,
                      width: 0, height: 0)
    
    containerTitleRating.anchor(top: genreImage.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0,
                      left: container.leadingAnchor, paddingLeft: 6, right: container.trailingAnchor, paddingRight: 6,
                      width: 0, height: 0)
    
    containerReleasedReview.anchor(top: containerTitleRating.bottomAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0,
                      left: container.leadingAnchor, paddingLeft: 6, right: container.trailingAnchor, paddingRight: 6,
                      width: 0, height: 0)
    
    startIcon.anchor(top: containerRating.topAnchor, paddingTop: 0, bottom: containerRating.bottomAnchor, paddingBottom: 0,
                     left: nil, paddingLeft: 4, right: ratingLabel.leadingAnchor, paddingRight: 4,
                     width: 0, height: 0)
    
    ratingLabel.anchor(top: containerRating.topAnchor, paddingTop: 0, bottom: containerRating.bottomAnchor, paddingBottom: 0,
                       left: nil, paddingLeft: 0, right: containerRating.trailingAnchor, paddingRight: 4,
                     width: 0, height: 0)
  
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
