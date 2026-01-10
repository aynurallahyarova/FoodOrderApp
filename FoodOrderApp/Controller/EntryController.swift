//
//  ViewController.swift
//  FoodOrderApp
//
//  Created by Aynur on 02.01.26.
//

import UIKit

class EntryController: UIViewController {
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var confirmePasswordText: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
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
        
    }
}
