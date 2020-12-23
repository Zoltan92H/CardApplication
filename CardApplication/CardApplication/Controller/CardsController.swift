//
//  CardsController.swift
//  CardApplication
//
//  Created by Hidegkuti Zoltán on 2020. 12. 21..
//

import UIKit
import RxSwift
import RxCocoa
import ImageSlideshow
import GTProgressBar



var progressValue: CGFloat = 0
let imageSlideShow = ImageSlideshow()
var availableString: String = ""
var currentString: String = ""
var current: CGFloat = 0

class CardsController: UIViewController {

	var value: CGFloat = 0
	var available: CGFloat = 0


	var chartValue: CGFloat = 0

	let progressBar = GTProgressBar()
	var cardListViewModel: CardListViewModel!
	let disposeBag = DisposeBag()
	var currentPage: Int = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Premium Card"
		let backButtonImage = UIImage(named: "ic_arrowleft")
		self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
		self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
//		self.navigationController?.navigationBar.backItem?.title = .none
		view.backgroundColor = .white
		configureViewController()
		configureImageSlider()
		loadingCardData()
		customizeProgressBar()
	}



	var cardAttribsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 0
		return stackView
	}()


	private let availableBalanceLabel: UILabel = {
		let label = UILabel()
		label.text = "Available"
		label.textColor = #colorLiteral(red: 0.07336392254, green: 0.1355724931, blue: 0.247576952, alpha: 1)
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 18)
		return label
	}()

	private let availableBalanceValue: UILabel = {
		let label = UILabel()
		label.text = String(availableString)
		label.textAlignment = .right
		label.textColor = #colorLiteral(red: 0.07336392254, green: 0.1355724931, blue: 0.247576952, alpha: 1)
		label.font = UIFont.boldSystemFont(ofSize: 18)
		return label
	}()

	private let minPaymentLabel: UILabel = {
		let label = UILabel()
		label.text = "Premium Card"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 20)
		return label
	}()

	private let dueDateLabel: UILabel = {
		let label = UILabel()
		label.text = "Premium Card"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 20)
		return label
	}()

	private let detailsButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Details", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.layer.cornerRadius = 5
		button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
		button.borderWidth = 1
		button.borderColor = .systemBlue
		button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
		return button
	}()

	private func loadingCardData() {
		let resources = Resource<[CardModel]>(url: URL(string: "https://raw.githubusercontent.com/wupdigital/interview-api/master/api/v1/cards.json")!)

		URLRequest.load(resource: resources)
			.subscribe(onNext: { cards in
				self.cardListViewModel = CardListViewModel(cards)
				DispatchQueue.main.async {
					self.updateUI(page: imageSlideShow.currentPage)
				}
			}).disposed(by:disposeBag)
	}

	func configureViewController() {
		view.addSubview(imageSlideShow)
		imageSlideShow.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 120, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: view.frame.width - 40, height: 200)

		view.addSubview(availableBalanceLabel)
		availableBalanceLabel.anchor(top: imageSlideShow.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 20)

		view.addSubview(availableBalanceValue)
		availableBalanceValue.anchor(top: imageSlideShow.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 60, height: 20)

		view.addSubview(progressBar)
		progressBar.anchor(top: availableBalanceLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 200, height: 20)

		view.addSubview(detailsButton)
		detailsButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0,paddingLeft: 100, paddingBottom: 130, paddingRight: 100, width: 160, height: 50)

		view.addSubview(cardAttribsStackView)
		cardAttribsStackView.anchor(top: progressBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, width: view.frame.width)

		reloadCardAttribs()
	}

	func configureImageSlider() {
		imageSlideShow.contentScaleMode = .scaleAspectFit
		let pageIndicator = UIPageControl()
		pageIndicator.currentPageIndicatorTintColor = UIColor.black
		pageIndicator.pageIndicatorTintColor = UIColor.lightGray
		imageSlideShow.pageIndicator = pageIndicator

		imageSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .under)

		imageSlideShow.currentPageChanged = { newPage in
			DispatchQueue.main.async {
				if newPage != self.currentPage {
					//self.updateUI(page: newPage)

				}
			}
		}



	}

	func loadImages(imageNames: [String], page: Int) {
		let imageInputs: [ImageSource] = imageNames.map({ ImageSource(image: UIImage(named: $0) ?? #imageLiteral(resourceName: "ic_alert")) })
		imageSlideShow.setImageInputs(imageInputs)
		self.currentPage = page
		imageSlideShow.setCurrentPage(page, animated: false)
	}

	@objc func handleShowSignUp() {
		guard currentPage < cardListViewModel.cardsVM.count else {
			return
		}

		let cardVM = cardListViewModel.cardsVM[currentPage]
		let controller = DetailViewController()
		controller.cardVM = cardVM
		navigationController?.pushViewController(controller, animated: true)
	}

	func updateUI(page: Int) {
		let cardImages = cardListViewModel.cardsVM.map({ $0.cardImage })
		let singleObservable: Observable<String> = Observable.from(cardImages).merge()
		let wholeSequence: Observable<[String]> = singleObservable.toArray()

		wholeSequence.subscribe(onNext: { imageNames in
			self.loadImages(imageNames: imageNames, page: page)
		}).disposed(by: disposeBag)

		guard page < cardListViewModel.cardsVM.count else {
			return
		}

		let cardVM = cardListViewModel.cardsVM[page]
		reloadCardAttribs()

		cardVM.currentBalance.subscribe(onNext: { currentBalance in

			cardVM.availableBalance.subscribe(onNext: { availableBalance in

				self.available = CGFloat(availableBalance)
				current = CGFloat(currentBalance)
				currentString = String(currentBalance)
				self.chartValue = self.available + current
				self.value = self.available / self.chartValue
				progressValue = self.value
				availableString = String(availableBalance)

				self.availableBalanceValue.text = String(availableBalance)
				self.progressBar.progress = 0

				self.progressBar.animateTo(progress: self.value) {
				  print("Animation completed")
				}

			}).disposed(by: self.disposeBag)

		}).disposed(by: disposeBag)

		cardVM.availableBalance.subscribe(onNext: { availableBalance in
			let cardAttribView = CardAttribView()
			self.cardAttribsStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Current Balance", value: String(availableBalance), shouldShowCurrency: true, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.currentBalance.subscribe(onNext: { currentBalance in
			let cardAttribView = CardAttribView()
			self.cardAttribsStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "Current Balance", value: String(currentBalance), shouldShowCurrency: true, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.minPayment.subscribe(onNext: { minPayment in
			let cardAttribView = CardAttribView()
			self.cardAttribsStackView.addArrangedSubview(cardAttribView)

			cardAttribView.updateUI(title: "Min. Payment", value: String(minPayment), shouldShowCurrency: true, currency: "USD")
		}).disposed(by: disposeBag)

		cardVM.dueDate.subscribe(onNext: { dueDate in
			let cardAttribView = CardAttribView()
			self.cardAttribsStackView.addArrangedSubview(cardAttribView)
			cardAttribView.updateUI(title: "due date", value: String(dueDate), shouldShowCurrency: false, currency: "USD")
		}).disposed(by: disposeBag)
	}



	func customizeProgressBar() {



		progressBar.orientation = .horizontal
		let primaryBlue = UIColor(rgb: 0x377AA4)
		progressBar.barFillColor = primaryBlue
		progressBar.cornerType = .rounded
		progressBar.barBorderColor = .lightGray
		progressBar.barBorderWidth = 1
		progressBar.direction = GTProgressBarDirection.anticlockwise
		progressBar.displayLabel = false
		let primaryOrange = UIColor(rgb: 0xF77F00)
		progressBar.barBackgroundColor = primaryOrange.withAlphaComponent(0.6)
		progressBar.barFillInset = 0


	}

	private func reloadCardAttribs() {
		for subview in cardAttribsStackView.subviews {
			subview.removeFromSuperview()
		}
	}
}
