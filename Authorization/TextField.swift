//
//  TextView.swift
//  Authorization
//
//  Created by Екатерина Григорьева on 15.08.2021.
//

import UIKit
import SnapKit

enum TextFieldType {
	case mail
	case password
	case phone
}

class TextField: UIView {
	
	
	private let button = UIButton(type: .custom)
	
	let textField = UITextField()
	
	private var type: TextFieldType
	
	init(type: TextFieldType) {
		self.type = type

		super.init(frame: .zero)
				
		switch type {
		case .mail:
			self.setupTextField()
			textField.textContentType = .emailAddress
			textField.autocapitalizationType = .none
			textField.keyboardType = .emailAddress
		case .phone:
			self.setupTextField()
			textField.textContentType = .telephoneNumber
			textField.keyboardType = .phonePad
		case .password:
			textField.textContentType = .password
			textField.autocapitalizationType = .none
			textField.isSecureTextEntry = true
			self.setupButton()
			
		}
		textField.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .semibold)
		self.lineUnder()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTextField() {
		self.addSubview(textField)
		
		textField.snp.makeConstraints { make in
			make.top.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(37)
		}
	}
	
	@objc func togglePasswordView(_ sender: UIButton) {
		
		textField.isSecureTextEntry = !textField.isSecureTextEntry
		if !textField.isSecureTextEntry {
			button.setImage(UIImage(systemName: "eye"), for: .normal)
		} else {
			button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
		}
		
	}
	
	private func setupButton() {
		self.addSubview(textField)
		
		textField.snp.makeConstraints { make in
			make.top.leading.bottom.equalToSuperview()
			make.trailing.equalToSuperview().offset(-30)
			make.height.equalTo(37)
		}
		
		button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
		button.tintColor = UIColor(red: 0.3064385653, green: 0.3462639153, blue: 0.3499338329, alpha: 1)
		
		button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
		self.addSubview(button)
		button.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.height.equalTo(27)
			make.width.equalTo(40)
			make.trailing.equalToSuperview()
		}
		button.contentVerticalAlignment = .fill
		button.contentHorizontalAlignment = .fill
		
	}
}

