//
//  CardAttribView.swift
//  CardApplication
//
//  Created by Hidegkuti Zoltán on 2020. 12. 23..
//

import UIKit


class CardAttribView: UIView {

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = UIFont(name: "Roboto-Regular", size: 20)
		let darkBlue = UIColor(rgb: 0x377AA4)
		label.textColor = darkBlue
		label.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .horizontal)
		return label
	}()

	private let currencyLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		label.textColor = .gray
		label.font = UIFont.systemFont(ofSize: 20)
		label.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
		return label
	}()

	private let valueLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .right
		let darkBlue2 = UIColor(rgb: 0x05293E)
		label.textColor = darkBlue2
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
		self.borderWidth = 0.25
		self.borderColor = .lightGray
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureView() {
		addSubview(titleLabel)
		titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 12, paddingLeft: 10, paddingBottom: 12, paddingRight: 0, height: 40)
		addSubview(valueLabel)
		valueLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 12, paddingRight: 10, width: 160, height: 40)
		addSubview(currencyLabel)
		currencyLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: valueLabel.leftAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 12, paddingRight: 10, height: 40)
	}

	func updateUI(title: String, value: String, shouldShowCurrency: Bool, currency: String? = nil) {
		titleLabel.text = title
		valueLabel.text = value
		currencyLabel.isHidden = !shouldShowCurrency
		currencyLabel.text = currency
	}

}
