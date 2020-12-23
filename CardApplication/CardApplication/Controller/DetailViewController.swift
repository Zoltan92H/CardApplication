//
//  DetailViewController.swift
//  CardApplication
//
//  Created by Hidegkuti Zoltán on 2020. 12. 23..
//

import UIKit
import RxSwift
import RxCocoa
import GTProgressBar

class DetailViewController: UIViewController {

	let disposeBag = DisposeBag()
	var progressBar = GTProgressBar()
	var cardVM: CardViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
		self.title = "Details"
		customizeProgressBar()

		//addToStack()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateUI()
	}

	private let backButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "ic_arrowleft"), for: .normal)
		button.tintColor = .systemBlue
		button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
		return button
	}()

	private let availableBalanceLabel: UILabel = {
		let label = UILabel()
		label.text = "Available"
		let statusBlue = UIColor(rgb: 0x004E7B)
		label.textColor = statusBlue
		label.textAlignment = .right
		label.font = UIFont.systemFont(ofSize: 15)
		return label
	}()

	private let availableBalanceValue: UILabel = {
		let label = UILabel()
		label.text = String(availableString)
		label.textAlignment = .right
		let statusBlue = UIColor(rgb: 0x004E7B)
		label.textColor = statusBlue
		label.font = UIFont.boldSystemFont(ofSize: 24)
		return label
	}()

	private let currentBalanceLabel: UILabel = {
		let label = UILabel()
		label.text = "Current"
		let statusBlue = UIColor(rgb: 0x004E7B)
		label.textColor = statusBlue
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 15)
		return label
	}()

	private let currentBalanceValue: UILabel = {
		let label = UILabel()
		label.text = String(currentString)
		label.textAlignment = .left
		let orange = UIColor(rgb: 0xF77F00)
		label.textColor = orange
		label.font = UIFont.boldSystemFont(ofSize: 24)
		return label
	}()

	private let balanceOverviewLabel: UILabel = {
		let label = UILabel()
		label.text = "Balance overview"
		label.textAlignment = .left
		label.font = UIFont(name: "Roboto-Regular", size: 18)
		label.textColor = .gray
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	private let accountDetailLabel: UILabel = {
		let label = UILabel()
		label.text = "Account details"
		label.textAlignment = .left
		label.font = UIFont(name: "Roboto-Regular", size: 18)
		label.textColor = .gray
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	private let emptyLabel: UILabel = {
		let label = UILabel()
		label.text = ""
		label.textAlignment = .left
		label.font = UIFont(name: "Roboto-Regular", size: 18)
		label.textColor = .gray
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	let scrollView: UIScrollView = {
		let v = UIScrollView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.backgroundColor = .white
		v.isScrollEnabled = true
		v.isDirectionalLockEnabled = true
		return v
	}()

	var cardAttribsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 0
		return stackView
	}()

	var balanceOverviewStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 0
		return stackView
	}()

	var mainCardStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 0
		return stackView
	}()


	@objc func handleBack() {
		navigationController?.popViewController(animated: true)
	}

	func configure() {
		view.addSubview(availableBalanceLabel)
		availableBalanceLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 110, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 80, height: 20)

		view.addSubview(currentBalanceLabel)
		currentBalanceLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 110, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 80, height: 20)

		view.addSubview(availableBalanceValue)
		availableBalanceValue.anchor(top: availableBalanceLabel.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 100, height: 20)

		view.addSubview(currentBalanceValue)
		currentBalanceValue.anchor(top: currentBalanceLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 100, height: 20)

		view.addSubview(progressBar)
		progressBar.anchor(top: availableBalanceValue.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: view.frame.width, height: 60)

		view.addSubview(scrollView)
		scrollView.anchor(top: progressBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 500)

		scrollView.addSubview(cardAttribsStackView)
		scrollView.bringSubviewToFront(cardAttribsStackView)
		cardAttribsStackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 40)

		scrollView.addSubview(balanceOverviewLabel)
		balanceOverviewLabel.anchor(top: cardAttribsStackView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 20, paddingRight: 0, width: 200, height: 40)

		scrollView.addSubview(balanceOverviewStackView)
		balanceOverviewStackView.anchor(top: balanceOverviewLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width)

		scrollView.addSubview(accountDetailLabel)
		accountDetailLabel.anchor(top: balanceOverviewStackView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 20, paddingRight: 0, width: 200, height: 40)

		scrollView.addSubview(mainCardStackView)
		mainCardStackView.anchor(top: accountDetailLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width)
		view.addSubview(emptyLabel)
		emptyLabel.anchor(top: mainCardStackView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 20, paddingRight: 0, width: 200, height: 40)

	}

	func customizeProgressBar() {
		progressBar.orientation = .horizontal
		let primaryBlue = UIColor(rgb: 0x377AA4)
		progressBar.barFillColor = primaryBlue
		progressBar.cornerType = .square
		progressBar.barBorderColor = .lightGray
		progressBar.barBorderWidth = 1
		progressBar.direction = GTProgressBarDirection.anticlockwise
		progressBar.displayLabel = false
		let primaryOrange = UIColor(rgb: 0xF77F00)
		progressBar.barBackgroundColor = primaryOrange.withAlphaComponent(0.6)
		progressBar.barFillInset = 0
		self.progressBar.progress = 0
		self.progressBar.animateTo(progress: progressValue) {
		  print("Animation completed")
		}
	}

	func updateUI() {
		reloadCardAttribs()

		cardVM.reservations.subscribe(onNext: { reservations in
			let cardAttribView = CardAttribView()
			self.cardAttribsStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Reservations/Pending", value: String(reservations), shouldShowCurrency: true, currency: "USD")
		}).disposed(by: disposeBag)


		cardVM.minPayment.subscribe(onNext: { balanceCarriedOverFromLastStatement in
			let cardAttribView = CardAttribView()
			self.balanceOverviewStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Balance carried over", value: String(balanceCarriedOverFromLastStatement), shouldShowCurrency: true, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.spendingsSinceLastStatement.subscribe(onNext: { spendingsSinceLastStatement in
			let cardAttribView = CardAttribView()
			self.balanceOverviewStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Total spendings", value: String(spendingsSinceLastStatement), shouldShowCurrency: true, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.yourLastRepayement.subscribe(onNext: { yourLastRepayment in
			let cardAttribView = CardAttribView()
			self.balanceOverviewStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Your last payment", value: String(yourLastRepayment), shouldShowCurrency: false, currency: "USD")
		}).disposed(by: disposeBag)


		cardVM.cardNumber.subscribe(onNext: { cardNumber in
			let cardAttribView = CardAttribView()
			self.mainCardStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Card number", value: String(cardNumber), shouldShowCurrency: false, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.cardHolderName.subscribe(onNext: { cardHolderName in
			let cardAttribView = CardAttribView()
			self.mainCardStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Card holder name", value: String(cardHolderName), shouldShowCurrency: false, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.friendlyName.subscribe(onNext: { friendlyName in
			let cardAttribView = CardAttribView()
			self.mainCardStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Friendly name", value: String(friendlyName), shouldShowCurrency: false, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.cvv.subscribe(onNext: { cvv in
			let cardAttribView = CardAttribView()
			self.mainCardStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "CVV", value: String(cvv), shouldShowCurrency: false, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.cardId.subscribe(onNext: { cardId in
			let cardAttribView = CardAttribView()
			self.mainCardStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "card ID", value: String(cardId), shouldShowCurrency: false, currency: "USD")
		}).disposed(by: disposeBag)



	}

	private func reloadCardAttribs() {
		for subview in cardAttribsStackView.subviews {
			subview.removeFromSuperview()
		}
	}
}
