//
//  CardViewModel.swift
//  CardApplication
//
//  Created by Hidegkuti Zoltán on 2020. 12. 23..
//

import Foundation
import RxSwift
import RxCocoa


struct CardListViewModel {
	let cardsVM: [CardViewModel]
}

extension CardListViewModel {

	init(_ cards: [CardModel]) {
		self.cardsVM = cards.compactMap(CardViewModel.init)
	}
}

extension CardListViewModel {

	func articleAt(_ index: Int) -> CardViewModel {
		return self.cardsVM[index]
	}
}

struct CardViewModel {
	private let cardModel: CardModel

	init(_ cardModel: CardModel) {
		self.cardModel = cardModel
	}
}

extension CardViewModel {

	var cardId: Observable<String> {
		return Observable<String>.just(cardModel.cardId)
	}
	var issuer: Observable<String> {
		return Observable<String>.just(cardModel.issuer)
	}
	var cardNumber: Observable<String> {
		return Observable<String>.just(cardModel.cardNumber)
	}
	var expirationDate: Observable<String> {
		return Observable<String>.just(cardModel.expirationDate)
	}
	var cardHolderName: Observable<String> {
		return Observable<String>.just(cardModel.cardHolderName)
	}
	var friendlyName: Observable<String> {
		return Observable<String>.just(cardModel.friendlyName)
	}
	var currency: Observable<String> {
		return Observable<String>.just(cardModel.currency)
	}
	var cvv: Observable<String> {
		return Observable<String>.just(cardModel.cvv)
	}
	var availableBalance: Observable<Int> {
		return Observable<Int>.just(cardModel.availableBalance)
	}
	var currentBalance: Observable<Int> {
		return Observable<Int>.just(cardModel.currentBalance)
	}
	var minPayment: Observable<Int> {
		return Observable<Int>.just(cardModel.minPayment)
	}
	var dueDate: Observable<String> {
//		let dueDate = DateFormatter.dayDate.date(from: cardModel.dueDate) ?? Date()
//		return Observable<Date>.just(dueDate)
		return Observable<String>.just(cardModel.dueDate)
	}
	var reservations: Observable<Int> {
		return Observable<Int>.just(cardModel.reservations)
	}
	var balanceCarriedOverFromLastStatement: Observable<Int> {
		return Observable<Int>.just(cardModel.balanceCarriedOverFromLastStatement)
	}
	var spendingsSinceLastStatement: Observable<Int> {
		return Observable<Int>.just(cardModel.spendingsSinceLastStatement)
	}
	var yourLastRepayement: Observable<String> {
		return Observable<String>.just(cardModel.yourLastRepayment)
	}
	var accountDetails: Observable<AccountDetail> {
		return Observable<AccountDetail>.just(cardModel.accountDetails)
	}
	var status: Observable<String> {
		return Observable<String>.just(cardModel.status)
	}
	var cardImage: Observable<String> {
		return Observable<String>.just(cardModel.cardImage)
	}




}

struct  AccountDetailViewmodel{

	let accountDetail: AccountDetail

	init(_ accountDetail: AccountDetail) {
		self.accountDetail = accountDetail
	}

}

extension AccountDetailViewmodel {

	var accountLimit: Observable<Int> {
		return Observable<Int>.just(accountDetail.accountLimit)
	}

	var accountNumber: Observable<String> {
		return Observable<String>.just(accountDetail.accountNumber)
	}

}
