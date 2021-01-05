//
//  ProfileModel.swift
//  Fun Games
//
//  Created by Ludin Nento on 20/12/20.
//

import Foundation

struct ProfileModel {
    static let nameKey = "name"
    static let countryKey = "country"
    static let facebookUsernameKey = "facebookUsername"
    static let emailKey = "email"
    static let githubUsernameKey = "github"
    static let stateKey = "state"
    static var stateLogin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: stateKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: stateKey)
        }
    }
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    static var country: String {
        get {
            return UserDefaults.standard.string(forKey: countryKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: countryKey)
        }
    }
    static var facebookUsername: String {
        get {
            return UserDefaults.standard.string(forKey: facebookUsernameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: facebookUsernameKey)
        }
    }
    static var email: String {
        get {
            return UserDefaults.standard.string(forKey: emailKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }
    static var githubUsername: String {
        get {
            return UserDefaults.standard.string(forKey: githubUsernameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: githubUsernameKey)
        }
    }
    
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
