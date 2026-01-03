//
//  ViewController.swift
//  FoodOrderApp
//
//  Created by Aynur on 02.01.26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLayoutSubviews()

        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.clipsToBounds = true
  
        animationView.layer.cornerRadius = animationView.frame.height / 2
        animationView.clipsToBounds = true
    }

    
    
    private func configureSegment(isSignInTapped: Bool) {
        leadingConstraint.constant = isSignInTapped ? 0 : 150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.signInButton.setTitleColor(isSignInTapped ? .white : .red, for: .normal)
            self.signUpButton.setTitleColor(isSignInTapped ? .red : .white, for: .normal)
        }
        
        
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        configureSegment(isSignInTapped: true)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        configureSegment(isSignInTapped: false)
    }
}

