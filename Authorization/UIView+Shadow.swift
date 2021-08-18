//
//  UIView+shadow.swift
//  Authorization
//
//  Created by Екатерина Григорьева on 16.08.2021.
//

import UIKit

extension UIView {
	func setupShadow() {
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.7
		self.layer.shadowOffset = .zero
		self.layer.shadowRadius = 2
	}
}
