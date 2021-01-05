//
//  UpdateProfileViewController.swift
//  Fun Games
//
//  Created by Ludin Nento on 23/11/20.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Nama Lengkap"
        return view
    }()
    
    let countryLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Asal Negara"
        return view
    }()
    
    let facebookLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Facebook Username"
        return view
    }()
    
    let emailLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Email"
        return view
    }()
    
    let githubLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Github Username"
        return view
    }()
    
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Nama lengkap"
        view.borderStyle = .roundedRect
        view.clearButtonMode = UITextField.ViewMode.always
        view.text = ProfileModel.name
        return view
    }()
    
    let countryTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Asal negara"
        view.borderStyle = .roundedRect
        view.clearButtonMode = UITextField.ViewMode.always
        view.text = ProfileModel.country
        return view
    }()
    
    let facebookTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Facebook username"
        view.borderStyle = .roundedRect
        view.clearButtonMode = UITextField.ViewMode.always
        view.text = ProfileModel.facebookUsername
        return view
    }()

    let emailTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Email"
        view.borderStyle = .roundedRect
        view.clearButtonMode = UITextField.ViewMode.always
        view.text = ProfileModel.email
        return view
    }()
    
    let githubUsernameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Github username"
        view.borderStyle = .roundedRect
        view.clearButtonMode = UITextField.ViewMode.always
        view.text = ProfileModel.githubUsername
        return view
    }()

    let mainView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
      view.setTitle("update_profile_btn".localized(identifier: "com.funproject.Fun-Games"), for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.setTitleColor(UIColor.white, for: .normal)
        view.addTarget(self, action: #selector(saveProfile(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      title = "update_profile_title".localized(identifier: "com.funproject.Fun-Games")
        view.backgroundColor = .systemBackground
        setScrollView()
        setInputView()
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
            .isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
            .isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
            .isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            .isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.addSubview(mainView)
    
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setInputView() {

        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution  = .fill
        mainStackView.spacing = 16
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameView = UIStackView()
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.axis = .vertical
        
        let countryView = UIStackView()
        countryView.translatesAutoresizingMaskIntoConstraints = false
        countryView.axis = .vertical
        
        let facebookView = UIStackView()
        facebookView.translatesAutoresizingMaskIntoConstraints = false
        facebookView.axis = .vertical
        
        let emailView = UIStackView()
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailView.axis = .vertical
        
        let githubView = UIStackView()
        githubView.translatesAutoresizingMaskIntoConstraints = false
        githubView.axis = .vertical
        
        nameView.addArrangedSubview(nameLabel)
        nameView.addArrangedSubview(nameTextField)
        
        countryView.addArrangedSubview(countryLabel)
        countryView.addArrangedSubview(countryTextField)
        
        facebookView.addArrangedSubview(facebookLabel)
        facebookView.addArrangedSubview(facebookTextField)
        
        emailView.addArrangedSubview(emailLabel)
        emailView.addArrangedSubview(emailTextField)
        
        githubView.addArrangedSubview(githubLabel)
        githubView.addArrangedSubview(githubUsernameTextField)
        
        mainStackView.addArrangedSubview(nameView)
        mainStackView.addArrangedSubview(countryView)
        mainStackView.addArrangedSubview(facebookView)
        mainStackView.addArrangedSubview(emailView)
        mainStackView.addArrangedSubview(githubView)
        mainStackView.addArrangedSubview(saveButton)
        mainView.addSubview(mainStackView)
        
        mainStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16).isActive = true
        mainStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
    }
    
    @objc func saveProfile(_ sender: UIButton) {
        if let name = nameTextField.text,
           let country = countryTextField.text,
           let facebook = facebookTextField.text,
           let email = emailTextField.text,
           let github = githubUsernameTextField.text {
            if name.isEmpty {
                alert("Nama Lengkap")
            } else if email.isEmpty {
                alert("Email")
            } else if country.isEmpty {
                alert("Country")
            } else if facebook.isEmpty {
                alert("Facebook Username")
            } else if github.isEmpty {
                alert("Github Username")
            } else {
                saveProfilData(name, country, facebook, email, github)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func saveProfilData(_ name: String, _ country: String, _ facebook: String, _ email: String, _ github: String) {
        ProfileModel.stateLogin = true
        ProfileModel.name = name
        ProfileModel.country = country
        ProfileModel.facebookUsername = facebook
        ProfileModel.email = email
        ProfileModel.githubUsername = github
    }
    func alert(_ message: String ) {
      let allertController = UIAlertController(title: "alert_information_title".localized(identifier: "com.funproject.Fun-Games"),
                                               message: "\(message) required", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        allertController.addAction(alertAction)
        self.present(allertController, animated: true, completion: nil)
    }
}
