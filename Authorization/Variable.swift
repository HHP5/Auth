//
//  Vatiable.swift
//  Authorization
//
//  Created by Екатерина Григорьева on 18.08.2021.
//

import UIKit

struct User {
	var mail: String = ""
	var phone: String = ""
	var password: String = ""
}

class Variable {

	var users: [User] = []
	var userNotExist: (() -> Void)?
	var userExist: ((User) -> Void)?
	
	init() {
		self.buildUser()
	}
	
	func dataEntry(mail: String, password: String, phone: String) {
		users.forEach { user in
			if user.mail != mail && user.password != password && user.phone != phone {
				self.userNotExist?()
			} else {
				self.userExist?(user)
			}
		}
	}
	
	private func buildUser() {
		// в этом месте должны получать данные об зарег. пользователях
		let loggedUser = User(mail: "qq@mail.ru", phone: "+79998887766", password: "qwerty")
		self.users.append(loggedUser)
	}
	
}
