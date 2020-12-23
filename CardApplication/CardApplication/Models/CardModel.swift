//
//  CardModel.swift
//  CardApplication
//
//  Created by Hidegkuti Zoltán on 2020. 12. 23..
//

import Foundation

struct CardModelResponse: Decodable {
	let cards: [CardModel]
}

struct CardModel: Decodable {
	let cardId: String
	let issuer: String
	let cardNumber: String
	let expirationDate: String
	let cardHolderName: String
	let friendlyName: String
	let currency: String
	let cvv: String
	let availableBalance: Int
	let currentBalance: Int
	let minPayment: Int
	let dueDate: String
	let reservations: Int
	let balanceCarriedOverFromLastStatement: Int
	let spendingsSinceLastStatement: Int
	let yourLastRepayment: String
	let accountDetails: AccountDetail
	let status: String
	let cardImage: String
}

struct AccountDetail: Decodable {
	let accountLimit: Int
	let accountNumber: String
}
