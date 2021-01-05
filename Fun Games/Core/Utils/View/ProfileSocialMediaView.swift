//
//  ProfileSocialMediaView.swift
//  Fun Games
//
//  Created by Ludin Nento on 21/11/20.
//

import UIKit

class ProfileSocialMediaView: UIStackView {
    let iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(iconView)
        addArrangedSubview(nameLabel)
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 10
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        iconView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        self.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.isLayoutMarginsRelativeArrangement = true
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

}
