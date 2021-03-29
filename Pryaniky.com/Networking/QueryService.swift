//
//  QueryService.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 22.03.2021.
//

import Foundation
import RxSwift
import UIKit

protocol IQueryService: class {
	func dataFrom(url: URL) -> Observable<MainListModel>
	func getDataAt(url: URL, completion: @escaping (Data, String) -> Void)
}

final class QueryService {
	private let defaultSession = URLSession(configuration: .default)
	private var dataTask: URLSessionDataTask?
	private var errorMessage = ""
	private var responseData = Data()
	
	typealias QueryResult = (Data, String) -> Void
}

private extension QueryService {
	func JSONParse(data: Data) -> (MainListModel, String) {
		var errorDescription = ""
		var entityModel = MainListModel(data: nil, view: nil)
		
		do {
			entityModel = try JSONDecoder().decode(MainListModel.self,
												   from: data)
		} catch let error {
			errorDescription = error.localizedDescription
		}
		
		return (entityModel, errorDescription)
	}
}

// MARK: IQueryService

extension QueryService: IQueryService {
	func getDataAt(url: URL, completion: @escaping QueryResult) {
		self.dataTask?.cancel()
		
		self.dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
			defer {
				self?.dataTask = nil
			}
			
			self?.responseData = Data()
			self?.errorMessage = ""
			
			if let error = error {
				self?.errorMessage = "Data task error: \(error.localizedDescription)\n"
			} else if let data = data,
					  let response = response as? HTTPURLResponse {
				if response.statusCode == 200 {
					self?.responseData = data
				} else {
					self?.errorMessage = "Data task error: code \(response.statusCode)\n"
				}
			}
			
			DispatchQueue.global(qos: .userInitiated).async {
				completion(self?.responseData ?? Data(), self?.errorMessage ?? "")
			}
		}
		self.dataTask?.resume()
	}
	
	func dataFrom(url: URL) -> Observable<MainListModel> {
		return Observable.create { [weak self] observer -> Disposable in
			var responseData = Data()
			var model = MainListModel(data: nil, view: nil)
			
			self?.getDataAt(url: url) { (data, error) in
				if error == "" {
					responseData = data
					model = self?.JSONParse(data: responseData).0 ?? MainListModel(data: nil, view: nil)
					observer.onNext(model)
				} else {
					print(error)
					observer.onError(error as! Error)
				}
			}
			
			return Disposables.create { }
		}
	}
}
