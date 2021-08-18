//
//  MainRouter.swift
//  Authorization
//
//  Created by Екатерина Григорьева on 15.08.2021.
//

import UIKit

class MainRouter {
	
	private let loginScreenNavController: UINavigationController
	private let loginScreenViewController: LoginScreenViewController

	internal init() {

		self.loginScreenViewController = LoginScreenViewController()
		self.loginScreenNavController = UINavigationController(rootViewController: self.loginScreenViewController)
		
		self.configLoginScreenViewController()
		
	}
	
	internal func start() -> UINavigationController {
		return self.loginScreenNavController
	}
	
	private func configLoginScreenViewController() {
		self.loginScreenViewController.view.backgroundColor = .white
		self.loginScreenNavController.navigationBar.isHidden = true
	}
}

