//
//  URLRequest.swift
//  CardApplication
//
//  Created by Hidegkuti Zoltán on 2020. 12. 23..
//

import UIKit
import RxCocoa
import RxSwift

struct Resource<T: Decodable> {
	let url: URL
}


extension URLRequest {

	static func load<T>(resource: Resource<T>) -> Observable<T> {

		return Observable.just(resource.url)
			.flatMap { (url) -> Observable<Data> in
				let request = URLRequest(url: url)
				return URLSession.shared.rx.data(request: request)
			}.map { (data) -> T in
				return try JSONDecoder().decode(T.self, from: data)
			}

	}

}
