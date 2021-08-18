//
//  ViewController.swift
//  Authorization
//
//  Created by Екатерина Григорьева on 15.08.2021.
//

import UIKit

class LoginScreenViewController: UIViewController, UITextFieldDelegate {
	
	private let screenView: LoginScreenView
	
	private var isDonePressed: Bool = false
	private let variable = Variable()
	
	// MARK: - Init
	
	init() {
		self.screenView = LoginScreenView()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupView()
		self.screenView.delegate = self
		
		self.bindToVariable()
		
	}
	
	private func setupView() {
		view.addSubview(screenView)
		screenView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.bottom.trailing.leading.equalToSuperview()
		}
		
		self.setupDelegates()
	}
	
	private func setupDelegates() {
		self.screenView.mailTextViewDelegate?.delegate = self
		self.screenView.passwordTextViewDelegate?.delegate = self
		self.screenView.phoneTextViewDelegate?.delegate = self
	}
	
	func bindToVariable() {
		variable.userNotExist = {
			let ac = UIAlertController(title: "",
									   message: "Такой пользователь не найден или ошибка ввода",
									   preferredStyle: .alert)
			let action = UIAlertAction(title: "OK", style: .cancel) {[weak self] _ in
				[self?.screenView.mailTextViewDelegate,
				 self?.screenView.passwordTextViewDelegate,
				 self?.screenView.phoneTextViewDelegate].forEach { textField in
					textField?.text = nil
					textField?.endEditing(true)
				}
			}
			ac.addAction(action)
			self.present(ac, animated: true)
		}
		
		variable.userExist = { [weak self] user in
			let destinationVC = SecondViewController()
			destinationVC.user = user
			self?.present(destinationVC, animated: true, completion: nil)
		}
	}
	
	
}

extension LoginScreenViewController: SignUpButtonDelegate {
	func signUpButtonPressed() {
		if let mail = screenView.mailTextViewDelegate?.text,
		   let password = screenView.passwordTextViewDelegate?.text,
		   let phone = screenView.phoneTextViewDelegate?.text {
			variable.dataEntry(mail: mail, password: password, phone: phone)
		}
	}
	
	func showAlert() {
		let ac = UIAlertController(title: "", message: "Заполните все поля", preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		ac.addAction(action)
		self.present(ac, animated: true, completion: nil)
	}
	
	func signUpLabelPressed() {
		// имитация перехода на страницу регистрации
		let destinationVC = RegistrationViewController()
		self.present(destinationVC, animated: true, completion: nil)
	}
}
