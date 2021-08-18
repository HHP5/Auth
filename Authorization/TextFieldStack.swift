//
//  File.swift
//  Authorization
//
//  Created by Екатерина Григорьева on 16.08.2021.
//

import UIKit

class TextFieldStack: UIView {
	
	var arrangedSubviews: [UIView]
	var spacing: CGFloat
	var axis: NSLayoutConstraint.Axis
	private var stack = UIStackView()
	
	init(arrangedSubviews: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis) {
		self.arrangedSubviews = arrangedSubviews
		self.spacing = spacing
		self.axis = axis
		super.init(frame: .zero)
		
		self.setupStack()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupStack() {
		stack = UIStackView(arrangedSubviews: arrangedSubviews)
		self.addSubview(stack)
		
		stack.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		stack.spacing = spacing
		stack.axis = axis
		stack.distribution = .fill
		
		if axis == .horizontal {
			stack.arrangedSubviews.first?.snp.makeConstraints { $0.width.equalTo(30) }
			stack.arrangedSubviews.first?.contentMode = .scaleAspectFit
			stack.arrangedSubviews.first?.tintColor = Constant.grayColor
			stack.distribution = .fillProportionally
		}
	}
}
