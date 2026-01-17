//
//  ViewController.swift
//  FoodOrderApp
//
//  Created by Aynur on 02.01.26.
//

import UIKit

class EntryController: UIViewController, EntryviewModelDelegate {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var confirmePasswordText: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private let viewModel = EntryViewModel()
    private var isSignInMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.delegate = self
        configureSegment(isSignInTapped: true)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    func changeRoot() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
                if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabbarController") as? UITabBarController {
                    if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.changeRoot(to: tabBarVC)
                    }
                }
            }
    private func configureUI() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = containerView.frame.height / 2
  
        animationView.clipsToBounds = true
        animationView.layer.cornerRadius = animationView.frame.height / 2
        
        resultButton.clipsToBounds = true
        resultButton.layer.cornerRadius = animationView.frame.height / 2
    }
    
    private func configureSegment(isSignInTapped: Bool) {
        self.isSignInMode = isSignInTapped
        confirmePasswordText.isHidden = isSignInTapped
        leadingConstraint.constant = isSignInTapped ? 0 : 150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.signInButton.setTitleColor(isSignInTapped ? .white : .red, for: .normal)
            self.signUpButton.setTitleColor(isSignInTapped ? .red : .white, for: .normal)
            self.resultButton.setTitle(isSignInTapped ? "Sign in" : "Sign up", for: .normal)
        }
    }

    @IBAction func signInTapped(_ sender: Any) {
        configureSegment(isSignInTapped: true)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        configureSegment(isSignInTapped: false)
    }
    
    @IBAction func resultButtonTapped(_ sender: Any) {
        if isSignInMode {
                    viewModel.signIn(email: emailTextField.text, password: passwordTextField.text)
                } else {
                    viewModel.SignUp(email: emailTextField.text,
                                     password: passwordTextField.text,
                                     confirmPassword: confirmePasswordText.text)
                }
            }
}
