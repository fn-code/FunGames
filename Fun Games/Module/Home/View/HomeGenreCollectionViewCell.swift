//
//  HomeHeaderView.swift
//  Fun Games
//
//  Created by Ludin Nento on 30/12/20.
//

import UIKit

class HomeGenreCollectionViewCell: UICollectionViewCell {
  
  let container: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.cornerRadius = 16
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let titleLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "GENRE"
    label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 18))
    label.textColor = .white
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
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
  
  let tintGenreImage: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0, alpha: 0.5)
    view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(container)
    container.addSubview(genreImage)
    container.addSubview(titleLabel)
    genreImage.addSubview(tintGenreImage)
    
    container.anchor(top: contentView.topAnchor, paddingTop: 0, bottom: contentView.bottomAnchor, paddingBottom: 0,
                     left: contentView.leadingAnchor, paddingLeft: 0, right: contentView.trailingAnchor, paddingRight: 0,
                     width: 0, height: 0)
    
    genreImage.anchor(top: container.topAnchor, paddingTop: 0, bottom: container.bottomAnchor, paddingBottom: 0,
                      left: container.leadingAnchor, paddingLeft: 0, right: container.trailingAnchor, paddingRight: 0,
                      width: 0, height: 0)
    
    tintGenreImage.anchor(top: genreImage.topAnchor, paddingTop: 0, bottom: genreImage.bottomAnchor, paddingBottom: 0,
                      left: genreImage.leadingAnchor, paddingLeft: 0, right: genreImage.trailingAnchor, paddingRight: 0,
                      width: 0, height: 0)
    
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: tintGenreImage.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: tintGenreImage.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
