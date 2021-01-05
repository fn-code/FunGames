//
//  GamesTableViewFavoriteCellTableViewCell.swift
//  Fun Games
//
//  Created by Ludin Nento on 24/11/20.
//

import UIKit

class GamesTableViewFavoriteCell: UITableViewCell {
    let name: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
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
    let favoriteButton: UIButton = {
        let view = UIButton()
        let iconLeft = UIImage(named: "trash")
        view.imageView?.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(iconLeft, for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .systemRed
        view.setTitle("Favorite", for: .normal)
        view.setTitle("Remove", for: .highlighted)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor.init(red: 234/255, green: 8/255, blue: 8/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.showsTouchWhenHighlighted = true
        
        view.imageView?.widthAnchor.constraint(equalToConstant: 12).isActive = true
        view.imageView?.heightAnchor.constraint(equalToConstant: 12).isActive = true
        view.imageView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.imageView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        
        view.preservesSuperviewLayoutMargins = true
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let safeArea = contentView.layoutMarginsGuide
        addSubview(name)
        addSubview(released)
        addSubview(ratingGenreStackView)
        addSubview(gameImage)
        addSubview(favoriteButton)
        
        gameImage.heightAnchor.constraint(equalToConstant: 96.0).isActive = true
        gameImage.widthAnchor.constraint(equalToConstant: 136.0).isActive = true
        gameImage.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        gameImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        name.leadingAnchor.constraint(equalTo: gameImage.trailingAnchor, constant: 8).isActive = true
        released.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4).isActive = true
        released.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        released.leadingAnchor.constraint(equalTo: gameImage.trailingAnchor, constant: 8).isActive = true
        
        ratingGenreStackView.addSubview(ratingLabel)
        ratingGenreStackView.addSubview(startIcon)
        ratingGenreStackView.addSubview(reviewerLabel)
        
        ratingLabel.topAnchor.constraint(equalTo: ratingGenreStackView.topAnchor, constant: 0).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 0).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: ratingGenreStackView.leadingAnchor, constant: 0).isActive = true
        startIcon.topAnchor.constraint(equalTo: ratingGenreStackView.topAnchor, constant: 0).isActive = true
        startIcon.bottomAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 0).isActive = true
        startIcon.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 6).isActive = true
        reviewerLabel.topAnchor.constraint(equalTo: ratingGenreStackView.topAnchor, constant: 0).isActive = true
        reviewerLabel.bottomAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 0).isActive = true
        reviewerLabel.leadingAnchor.constraint(equalTo: startIcon.trailingAnchor, constant: 8).isActive = true
        
        ratingGenreStackView.topAnchor.constraint(equalTo: released.bottomAnchor, constant: 6).isActive = true
        ratingGenreStackView.leadingAnchor.constraint(equalTo: gameImage.trailingAnchor, constant: 8).isActive = true
        ratingGenreStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        favoriteButton.topAnchor.constraint(equalTo: ratingGenreStackView.bottomAnchor, constant: 8).isActive = true
        favoriteButton.leadingAnchor.constraint(equalTo: gameImage.trailingAnchor, constant: 8).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
