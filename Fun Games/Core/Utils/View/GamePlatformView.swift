//
//  GamePlatformView.swift
//  Fun Games
//
//  Created by Ludin Nento on 21/11/20.
//

import UIKit
import Game

class GamePlatformView: UIStackView {
  let platformIcon: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "platform")
    view.widthAnchor.constraint(equalToConstant: 20).isActive = true
    view.heightAnchor.constraint(equalToConstant: 20).isActive = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let platformNameLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.boldSystemFont(ofSize: 16)
    view.textColor = .darkText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let platformReleasedLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 14)
    view.textColor = .darkGray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let platformRequirmentMinLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.boldSystemFont(ofSize: 14)
    view.text = "Requirments Minimum : "
    view.textColor = .darkText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let platformRequirmentMinDescLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 14)
    view.textColor = .darkGray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let platformRequirmentRecLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.boldSystemFont(ofSize: 14)
    view.text = "Requirments Recommended : "
    view.textColor = .darkText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  let platformRequirmentRecDescLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont.systemFont(ofSize: 14)
    view.textColor = .darkGray
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var name: String
  var released: String
  var requirment: RequirementDomainModel?
  
  required init(name: String, released: String, requirment: RequirementDomainModel?) {
    self.name = name
    self.released = released
    self.requirment = requirment
    let platformTitleView = UIStackView()
    let platformIconView = UIStackView()
    let platformReqMinimumView = UIStackView()
    let platformReqRecomendedView = UIStackView()
    let platformRequirmentMainView = UIStackView()
    let platformRequirementContentView = UIStackView()
    platformTitleView.axis = .vertical
    platformTitleView.distribution = .fill
    platformTitleView.alignment = .fill
    platformTitleView.spacing = 4
    platformTitleView.translatesAutoresizingMaskIntoConstraints = false
    platformTitleView.addArrangedSubview(platformNameLabel)
    platformTitleView.addArrangedSubview(platformReleasedLabel)
    platformIconView.axis = .horizontal
    platformIconView.distribution = .fill
    platformIconView.alignment = .center
    platformIconView.spacing = 10
    platformIconView.translatesAutoresizingMaskIntoConstraints = false
    platformIconView.addArrangedSubview(platformIcon)
    platformIconView.addArrangedSubview(platformTitleView)
    platformReqMinimumView.axis = .vertical
    platformReqMinimumView.distribution = .fill
    platformReqMinimumView.alignment = .fill
    platformReqMinimumView.spacing = 2
    platformReqMinimumView.translatesAutoresizingMaskIntoConstraints = false
    platformReqMinimumView.addArrangedSubview(platformRequirmentMinLabel)
    platformReqMinimumView.addArrangedSubview(platformRequirmentMinDescLabel)
    platformRequirmentMinDescLabel.numberOfLines = 0
    platformRequirmentMinDescLabel.leadingAnchor
      .constraint(equalTo: platformReqMinimumView.leadingAnchor, constant: 0).isActive = true
    platformRequirmentMinDescLabel.trailingAnchor
      .constraint(equalTo: platformReqMinimumView.trailingAnchor, constant: 0).isActive = true
    platformReqRecomendedView.axis = .vertical
    platformReqRecomendedView.distribution = .fill
    platformReqRecomendedView.alignment = .fill
    platformReqRecomendedView.spacing = 2
    platformReqRecomendedView.translatesAutoresizingMaskIntoConstraints = false
    platformReqRecomendedView.addArrangedSubview(platformRequirmentRecLabel)
    platformReqRecomendedView.addArrangedSubview(platformRequirmentRecDescLabel)
    platformRequirmentRecDescLabel.numberOfLines = 0
    platformRequirmentRecDescLabel.leadingAnchor
      .constraint(equalTo: platformReqRecomendedView.leadingAnchor, constant: 0)
      .isActive = true
    platformRequirmentRecDescLabel.trailingAnchor
      .constraint(equalTo: platformReqRecomendedView.trailingAnchor, constant: 0)
      .isActive = true
    platformRequirmentMainView.axis = .vertical
    platformRequirmentMainView.distribution = .fill
    platformRequirmentMainView.alignment = .fill
    platformRequirmentMainView.spacing = 4
    platformRequirmentMainView.translatesAutoresizingMaskIntoConstraints = false
    platformRequirmentMainView.addArrangedSubview(platformReqMinimumView)
    platformRequirmentMainView.addArrangedSubview(platformReqRecomendedView)
    platformRequirementContentView.axis = .vertical
    platformRequirementContentView.distribution = .fill
    platformRequirementContentView.alignment = .fill
    platformRequirementContentView.spacing = 6
    platformRequirementContentView.translatesAutoresizingMaskIntoConstraints = false
    platformRequirementContentView.addArrangedSubview(platformReqMinimumView)
    platformRequirementContentView.addArrangedSubview(platformRequirmentMainView)
    if requirment?.minimum != "" {
      let htmlMinimum = "<div style='font-size:14px;'>\(String(describing: requirment?.minimum))</div>".data(using: .utf8)!
      let minimumString = try? NSAttributedString(
        data: htmlMinimum,
        options: [.documentType: NSAttributedString.DocumentType.html],
        documentAttributes: nil)
      platformRequirmentMinDescLabel.attributedText = minimumString
    } else {
      let htmlMinimum = "<div style='font-size:14px;'><i>Tidak Tersedia</i></div>".data(using: .utf8)!
      let minimumString = try? NSAttributedString(
        data: htmlMinimum,
        options: [.documentType: NSAttributedString.DocumentType.html],
        documentAttributes: nil)
      platformRequirmentMinDescLabel.attributedText = minimumString
    }
    
    if requirment?.recommended != "" {
      let htmlRecomended = "<div style='font-size:14px;'>\(String(describing: self.requirment?.recommended))</div>".data(using: .utf8)!
      let recomendedString = try? NSAttributedString(
        data: htmlRecomended,
        options: [.documentType: NSAttributedString.DocumentType.html],
        documentAttributes: nil)
      platformRequirmentRecDescLabel.attributedText = recomendedString
    } else {
      let htmlRecomended = "<div style='font-size:14px;'><i>Tidak Tersedia</i></div>".data(using: .utf8)!
      let recomendedString = try? NSAttributedString(
        data: htmlRecomended,
        options: [.documentType: NSAttributedString.DocumentType.html],
        documentAttributes: nil)
      platformRequirmentRecDescLabel.attributedText = recomendedString
    }
    
    platformNameLabel.text = name
    platformReleasedLabel.text = "Released \(released)"
    super.init(frame: CGRect.zero)
    axis = .vertical
    distribution = .fill
    alignment = .fill
    spacing = 16
    translatesAutoresizingMaskIntoConstraints = false
    addArrangedSubview(platformIconView)
    addArrangedSubview(platformRequirementContentView)
  }
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
