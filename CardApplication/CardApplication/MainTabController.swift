//
//  ViewController.swift
//  CardApplication
//
//  Created by Hidegkuti Zoltán on 2020. 12. 16..
//

import UIKit

class MainTabController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewControllers()
	}


	func configureViewControllers() {

		view.backgroundColor = .white

		let layout = UICollectionViewFlowLayout()

		let cards = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "nav_cards"), selectedImage: #imageLiteral(resourceName: "nav_cards"), rootViewController: CardsController())

		let transactions = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "nav_trans"), selectedImage: #imageLiteral(resourceName: "nav_trans"), rootViewController: TransactionsController())

		let statements = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "nav_state"), selectedImage: #imageLiteral(resourceName: "nav_state"), rootViewController: StatementsController())

		let more = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "nav_more"), selectedImage: #imageLiteral(resourceName: "nav_more"), rootViewController: MoreController())


		viewControllers = [cards, transactions, statements, more]

		tabBar.tintColor = .black

	}

	func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
		let nav = UINavigationController(rootViewController:  rootViewController)
		nav.tabBarItem.image = unselectedImage
		nav.tabBarItem.selectedImage = selectedImage
		nav.navigationBar.tintColor = .black
		return nav
	}

}

