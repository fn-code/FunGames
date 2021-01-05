//
//  CellBuilder.swift
//  Fun Games
//
//  Created by Ludin Nento on 01/01/21.
//

import UIKit
import Genre
import Game
import SDWebImage
import Common

public class CellBuilder {
  public static func getHomeGenreCell(collectionView: UICollectionView, indexPath: IndexPath, genre: GenreDomainModel) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genre-cell", for: indexPath) as? HomeGenreCollectionViewCell {
      
      if !genre.imageBackground.isEmpty {
        cell.genreImage.sd_setImage(with: URL(string: genre.imageBackground), completed: nil)
      } else {
        cell.genreImage.image = UIImage(named: "no_photo")
      }
      cell.titleLabel.text = genre.name
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  public static func getHomeFavoriteCell(collectionView: UICollectionView, indexPath: IndexPath, favorite: FavoriteDomainModel) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favorite-cell", for: indexPath) as? HomeFavoriteCollectionViewCell {
      
      if let image = favorite.image, !image.isEmpty {
        cell.genreImage.sd_setImage(with: URL(string: image), completed: nil)
      } else {
        cell.genreImage.image = UIImage(named: "no_photo")
      }
      
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
      dateFormatter.dateFormat = "yyyy-MM-dd"
      
      let date = dateFormatter.date(from: (favorite.released ?? "")) ?? Date()
      let dateFormatterPrint = DateFormatter()
      dateFormatterPrint.dateFormat = "MMM dd,yyyy"
      let released = dateFormatterPrint.string(from: date)
      
      cell.titleLabel.text = favorite.name
      cell.releaseDateLabel.text = released
      cell.ratingLabel.text = "\(favorite.rating ?? 0)"
      cell.reviewsLabel.text = RatingTransform.get(ratingCount: Int(favorite.ratingCount ?? 0))
      
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  public static func getHomePopularCell(collectionView: UICollectionView, indexPath: IndexPath, game: GameDomainModel) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popular-cell", for: indexPath) as? HomePopularCollectionView {
      
      if let image = game.backgroundImage, !image.isEmpty {
        cell.gameImage.sd_setImage(with: URL(string: image), completed: nil)
      } else {
        cell.gameImage.image = UIImage(named: "no_photo")
      }
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
      dateFormatter.dateFormat = "yyyy-MM-dd"
      
      let date = dateFormatter.date(from: (game.released ?? "")) ?? Date()
      let dateFormatterPrint = DateFormatter()
      dateFormatterPrint.dateFormat = "MMM dd,yyyy"
      let released = dateFormatterPrint.string(from: date)
      
      cell.name.text = game.name
      cell.released.text = released
      cell.ratingLabel.text = "\(game.rating)"
      cell.reviewerLabel.text = RatingTransform.get(ratingCount: Int(game.ratingsCount))
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
}
