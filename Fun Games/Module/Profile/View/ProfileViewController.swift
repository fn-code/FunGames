//
//  ProfileViewController.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/11/20.
//

import UIKit

class ProfileViewController: UIViewController {
    let profilView: ProfileImageDescView = {
        let view = ProfileImageDescView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let facebookView: ProfileSocialMediaView = {
        let view = ProfileSocialMediaView()
        view.axis = .horizontal
        view.iconView.image = UIImage(named: "facebook-logo-2019")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let mailView: ProfileSocialMediaView = {
        let view = ProfileSocialMediaView()
        view.axis = .horizontal
        view.iconView.image = UIImage(named: "mail")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let githubView: ProfileSocialMediaView = {
        let view = ProfileSocialMediaView()
        view.axis = .horizontal
        view.iconView.image = UIImage(named: "github")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sosialMediaLabel: UILabel = {
        let view = UILabel()
        view.text = "Sosial Media"
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let contentSosial: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let mainProfilView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "profile_title".localized(identifier: "com.funproject.Fun-Games")
        view.addSubview(mainProfilView)
        setNavigationView()
        mainProfilView.addSubview(profilView)
        mainProfilView.addSubview(contentSosial)
        setProvilView()
        setSocialMedia()
        mainProfilView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        mainProfilView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
            .isActive = true
        mainProfilView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainProfilView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        ProfileModel.synchronize()
        facebookView.nameLabel.text = ProfileModel.facebookUsername
        mailView.nameLabel.text = ProfileModel.email
        githubView.nameLabel.text = ProfileModel.githubUsername
        profilView.countryLabel.text = ProfileModel.country
        profilView.nameLabel.text = ProfileModel.name
    }
    private func setNavigationView() {
        let menuBtnEdit = UIButton(type: .custom)
        menuBtnEdit.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtnEdit.setImage(UIImage(named: "edit"), for: .normal)
        menuBtnEdit.addTarget(self, action: #selector(self.updateTapped(_:)), for: .touchUpInside)
        
        let rightItemButtonEdit = UIBarButtonItem(customView: menuBtnEdit)
        rightItemButtonEdit.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        rightItemButtonEdit.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        navigationItem.rightBarButtonItem = rightItemButtonEdit
    }
    @objc func updateTapped(_ sender: Any) {
        let updateProfileView = UpdateProfileViewController()
        navigationController?.pushViewController(updateProfileView, animated: true)
    }
    private func setProvilView() {
        profilView.topAnchor.constraint(equalTo: mainProfilView.topAnchor).isActive = true
        profilView.leadingAnchor.constraint(equalTo: mainProfilView.leadingAnchor).isActive = true
        profilView.trailingAnchor.constraint(equalTo: mainProfilView.trailingAnchor).isActive = true
    }
    private func setSocialMedia() {
        contentSosial.addSubview(sosialMediaLabel)
        contentSosial.addSubview(facebookView)
        contentSosial.addSubview(mailView)
        contentSosial.addSubview(githubView)
        sosialMediaLabel.topAnchor.constraint(equalTo: contentSosial.topAnchor, constant: 8).isActive = true
        sosialMediaLabel.leadingAnchor.constraint(equalTo: contentSosial.leadingAnchor, constant: 16).isActive = true
        sosialMediaLabel.trailingAnchor.constraint(equalTo: contentSosial.trailingAnchor, constant: 16).isActive = true
        facebookView.topAnchor.constraint(equalTo: sosialMediaLabel.bottomAnchor, constant: 8).isActive = true
        facebookView.leadingAnchor.constraint(equalTo: contentSosial.leadingAnchor, constant: 8).isActive = true
        facebookView.trailingAnchor.constraint(equalTo: contentSosial.trailingAnchor, constant: 8).isActive = true
        mailView.topAnchor.constraint(equalTo: facebookView.bottomAnchor, constant: 0).isActive = true
        mailView.leadingAnchor.constraint(equalTo: contentSosial.leadingAnchor, constant: 8).isActive = true
        mailView.trailingAnchor.constraint(equalTo: contentSosial.trailingAnchor, constant: 8).isActive = true
        githubView.topAnchor.constraint(equalTo: mailView.bottomAnchor, constant: 0).isActive = true
        githubView.leadingAnchor.constraint(equalTo: contentSosial.leadingAnchor, constant: 8).isActive = true
        githubView.trailingAnchor.constraint(equalTo: contentSosial.trailingAnchor, constant: 8).isActive = true
        contentSosial.topAnchor.constraint(equalTo: profilView.countryLabel.bottomAnchor, constant: 30)
            .isActive = true
        contentSosial.leadingAnchor.constraint(equalTo: mainProfilView.leadingAnchor).isActive = true
        contentSosial.trailingAnchor.constraint(equalTo: mainProfilView.trailingAnchor).isActive = true
    }
}
