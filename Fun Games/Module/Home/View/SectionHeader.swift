//
//  SectionHeader.swift
//  Fun Games
//
//  Created by Ludin Nento on 01/01/21.
//

import UIKit

class SectionHeader: UICollectionReusableView {
  
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  
  let viewButton: UIButton = {
    let view = UIButton()
    view.setTitle("View All", for: .normal)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    view.setTitleColor(UIColor.black, for: .normal)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    let separator = UIView(frame: .zero)
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.backgroundColor = .quaternaryLabel
    
    let stackViewTitle = UIStackView(arrangedSubviews: [titleLabel, viewButton])
    let stackView = UIStackView(arrangedSubviews: [separator, stackViewTitle, subtitleLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    addSubview(stackView)
    
    stackViewTitle.distribution = .fill
    stackViewTitle.alignment = .fill
    stackViewTitle.translatesAutoresizingMaskIntoConstraints = false
    stackViewTitle.axis = .horizontal
    
    NSLayoutConstraint.activate([
      separator.heightAnchor.constraint(equalToConstant: 1),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
    
    stackView.setCustomSpacing(10, after: separator)
    
    style()
  }
  
  private func style() {
    titleLabel.textColor = .label
    titleLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .bold))
    subtitleLabel.textColor = .secondaryLabel
  }
}
