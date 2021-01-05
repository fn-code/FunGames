//
//  LayoutBuilder.swift
//  Fun Games
//
//  Created by Ludin Nento on 31/12/20.
//
import UIKit

class LayoutBuilder {
  public static func buildHomeHorizontalSectionLayout(
    size: NSCollectionLayoutSize,
    itemInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0),
    sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 16.0, bottom: 16.0, trailing: 16.0)
  ) -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .fractionalHeight(1.0)))
    item.contentInsets = itemInset
    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 1)
    let section = NSCollectionLayoutSection(group: group)
    
    section.contentInsets = sectionInset
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    section.interGroupSpacing = 16
    
    let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                         heightDimension: .estimated(100))
    
    let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                          elementKind: UICollectionView.elementKindSectionHeader,
                                                                          alignment: .top)
    section.boundarySupplementaryItems = [layoutSectionHeader]
    return section
  }
  
  public static func buildTableSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .fractionalHeight(1.0)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .estimated(90))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0)
    
    let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                         heightDimension: .estimated(100))
    let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                          elementKind: UICollectionView.elementKindSectionHeader,
                                                                          alignment: .top)
    section.boundarySupplementaryItems = [layoutSectionHeader]
    return section
  }
  
}
