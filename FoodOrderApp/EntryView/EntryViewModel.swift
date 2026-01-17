//
//  EntryViewModel.swift
//  FoodOrderApp
//
//  Created by Aynur on 17.01.26.
//

import Foundation

protocol EntryviewModelDelegate: AnyObject {
    func showAlert(message: String)
    func changeRoot()
}
class EntryViewModel {
    weak var delegate: EntryviewModelDelegate?
    private let userKey = "SavedUser"
    private let loginKey = "isLogin"
    
    func SignUp(email: String?, password: String?, confirmPassword: String?) {
        guard let email = email, !email.isEmpty, let password = password, !password.isEmpty, let confirmPassword = confirmPassword,!confirmPassword.isEmpty else {
            delegate?.showAlert(message: "Please fill all fields")
            return
        }
        
        if password != confirmPassword {
            delegate?.showAlert(message: "Passwords do not match")
            return
        }
        let user = User(email: email, password: password)
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.set(true, forKey: loginKey)
            delegate?.changeRoot()
        }
    }
    func signIn(email: String?, password: String?) {
            guard let email = email, !email.isEmpty,
                  let password = password, !password.isEmpty else {
                delegate?.showAlert(message: "Please fill all fields.")
                return
            }
            guard let savedData = UserDefaults.standard.data(forKey: userKey),
                  let savedUser = try? JSONDecoder().decode(User.self, from: savedData) else {
                delegate?.showAlert(message: "No user found. Please sign up first.")
                return
            }
            guard email == savedUser.email && password == savedUser.password else {
                delegate?.showAlert(message: "Invalid email or password.")
                return
            }
            UserDefaults.standard.set(true, forKey: loginKey)
            
            delegate?.changeRoot()
    }

}
