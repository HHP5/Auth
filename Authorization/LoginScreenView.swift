//
//  LoginScreenView.swift
//  Authorization
//
//  Created by Екатерина Григорьева on 15.08.2021.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding

protocol SignUpButtonDelegate: class {
	func signUpButtonPressed()
	func showAlert()
	func signUpLabelPressed()
}

class LoginScreenView: UIView {
	// MARK: - IBOutlets
	var phoneTextViewDelegate: UITextField?
	var mailTextViewDelegate: UITextField?
	var passwordTextViewDelegate: UITextField?
	
	weak var delegate: SignUpButtonDelegate?
	
	private lazy var scroll: TPKeyboardAvoidingScrollView = {
		let scroll = TPKeyboardAvoidingScrollView()
		scroll.alwaysBounceVertical = true
		scroll.alwaysBounceHorizontal = false
		scroll.showsVerticalScrollIndicator = false
		return scroll
	}()
	
	private lazy var headingLabel: UILabel = {
		let label = UILabel()
		label.text = "Sign Up"
		label.font = UIFont.systemFont(ofSize: 30)
		label.textColor = Constant.grayColor
		label.textAlignment = .center
		return label
	}()
	
	private lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.text = "Fill the details & create your account"
		label.font = UIFont.systemFont(ofSize: 20)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.textColor = Constant.grayColor
		return label
	}()
	
	private lazy var mainImage: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "image")
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	private lazy var mailTextView = TextField(type: .mail)
	private lazy var passwordTextView = TextField(type: .password)
	private lazy var phoneTextView = TextField(type: .phone)

	private lazy var signUpButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .red
		button.setTitle("Sign Up", for: .normal)
		button.tintColor = .white
		button.layer.cornerRadius = 8
		button.addTarget(self, action: #selector(signUpButtonPressed(_:)), for: .touchUpInside)
		return button
	}()
	
	private lazy var bottomLabel: UILabel = {
		let label = UILabel()
		label.text = "Don't have an account?"
		label.font = UIFont.systemFont(ofSize: 15)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.textColor = Constant.grayColor
		return label
	}()
	
	private lazy var signUpLabel: UIButton = {
		let label = UIButton()
		label.setTitle("Sign Up", for: .normal)
		label.backgroundColor = .white
		label.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		label.setTitleColor(Constant.blueColor, for: .normal)
		label.addTarget(self, action: #selector(signUpLabelPressed), for: .touchUpInside)
		return label
	}()
	
	
	// MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.phoneTextViewDelegate = phoneTextView.textField
		self.passwordTextViewDelegate = passwordTextView.textField
		self.mailTextViewDelegate = mailTextView.textField

		self.setup()
		self.setConstraints()

	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Actions

	@objc
	private func signUpButtonPressed(_ sender: UIButton) {
		if !mailTextView.textField.text!.isEmpty && !passwordTextView.textField.text!.isEmpty && !phoneTextView.textField.text!.isEmpty {
			delegate?.signUpButtonPressed()
		} else {
			delegate?.showAlert()
		}
	}
	
	@objc
	private func signUpLabelPressed() {
		delegate?.signUpLabelPressed()
	}
	
	// MARK: - Private Methods

	private func setup() {
		self.addSubview(scroll)
		
		scroll.addSubview(headingLabel)
		scroll.addSubview(detailLabel)
		scroll.addSubview(mainImage)
	
	}
	
	private func setConstraints() {
		scroll.snp.makeConstraints { $0.edges.equalToSuperview() }

		headingLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(30)
			make.centerX.equalToSuperview()
		}

		detailLabel.snp.makeConstraints { make in
			make.top.equalTo(headingLabel.snp.bottom).offset(15)
			make.leading.equalToSuperview().inset(20)
			make.width.equalTo(scroll).inset(20)
		}

		mainImage.snp.makeConstraints { make in
			make.top.equalTo(detailLabel.snp.bottom).offset(15)
			make.centerX.equalToSuperview()
			make.height.equalTo(250)
		}
		
		self.setupTextFieldStack()
	}
	
	private func setupTextFieldStack() {
		
		let mailImage = UIImageView(image: UIImage(systemName: "envelope.open"))
		let fillMail = UIImageView(image: UIImage(systemName: "envelope.fill"))
		let phoneImage = UIImageView(image: UIImage(systemName: "iphone"))

		let mailLabel = UILabel()
		mailLabel.text = "Mail"
		let passwordLabel = UILabel()
		passwordLabel.text = "Password"
		let phoneLabel = UILabel()
		phoneLabel.text = "Your phone"
		
		[mailLabel,passwordLabel,phoneLabel].forEach { label in
			label.font = UIFont.systemFont(ofSize: 15)
			label.textColor = Constant.grayColor
		}
		
		let mailStack = TextFieldStack(arrangedSubviews: [fillMail, TextFieldStack(arrangedSubviews: [mailLabel, mailTextView], spacing: 1.0, axis: .vertical)], spacing: 15.0, axis: .horizontal)

		let passwordStack = TextFieldStack(arrangedSubviews: [mailImage, TextFieldStack(arrangedSubviews: [passwordLabel, passwordTextView], spacing: 1.0, axis: .vertical)], spacing: 15.0, axis: .horizontal)

		let phoneStack = TextFieldStack(arrangedSubviews: [phoneImage, TextFieldStack(arrangedSubviews: [phoneLabel, phoneTextView], spacing: 1.0, axis: .vertical)], spacing: 15.0, axis: .horizontal)
		
		let stack = TextFieldStack(arrangedSubviews: [mailStack, passwordStack, phoneStack], spacing: 15.0, axis: .vertical)

		scroll.addSubview(stack)

		stack.snp.makeConstraints { make in
			make.top.equalTo(mainImage.snp.bottom).offset(20)
			make.leading.equalToSuperview().offset(20)
			make.width.equalTo(scroll).inset(25)
		}
		
		self.setupButton(stack: stack)
		
		scroll.tpKeyboardAvoiding_findFirstResponderBeneathView(mailTextView)
		scroll.tpKeyboardAvoiding_findFirstResponderBeneathView(passwordTextView)
		scroll.tpKeyboardAvoiding_findFirstResponderBeneathView(phoneTextView)
	}
	
	private func setupButton(stack: TextFieldStack) {
		scroll.addSubview(signUpButton)

		signUpButton.snp.makeConstraints { make in
			make.top.equalTo(stack.snp.bottom).offset(30)
			make.centerX.equalToSuperview()
			make.width.equalTo(250)
			make.height.equalTo(50)
		}
		
		signUpButton.setupShadow()
		setupBottomLabel(view: signUpButton)
	}
	
	private func setupBottomLabel(view: UIView) {
		
		scroll.addSubview(signUpLabel)
		scroll.addSubview(bottomLabel)
		bottomLabel.snp.makeConstraints { make in
			make.top.equalTo(view.snp.bottom).offset(15)
			make.leading.equalTo(view.snp.leading)
		}
		
		signUpLabel.snp.makeConstraints { make in
			make.top.equalTo(view.snp.bottom).offset(15)
			make.leading.equalTo(bottomLabel.snp.trailing).offset(10)
			make.height.equalTo(bottomLabel)
		}
	}
	
}

