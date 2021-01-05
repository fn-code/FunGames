//
//  ProfileImageDescView.swift
//  Fun Games
//
//  Created by Ludin Nento on 21/11/20.
//

import UIKit

class ProfileImageDescView: UIStackView {

    let profilImageView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "profil")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Khairudin Firdaus Nento"
        view.font = UIFont.systemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let countryLabel: UILabel = {
        let view = UILabel()
        view.text = "Indonesia"
        view.font = UIFont.systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setProfilImageView()
        setNameLabel()
        setCountryLabel()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setNameLabel() {
        self.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: profilImageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    private func setCountryLabel() {
        self.addSubview(countryLabel)
        countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        countryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    private func setProfilImageView() {
        self.addSubview(profilImageView)
        profilImageView.widthAnchor.constraint(equalToConstant: 151).isActive = true
        profilImageView.heightAnchor.constraint(equalToConstant: 151).isActive = true
        profilImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        profilImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.profilImageView.layer.cornerRadius = self.profilImageView.frame.size.width/2
        })
    }

}
