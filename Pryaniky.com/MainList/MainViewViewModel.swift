//
//  MainListViewModel.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 21.03.2021.
//

import Foundation
import RxSwift

protocol IMainListViewModelInput: class {
//	Входной протокол
	func fetchData()
	var list: PublishSubject<[String]> { get }
}

protocol IMainListViewModelOutput: class {
//	Выходной протокол
}

final class MainListViewModel {
	private var model: MainListModel
	private var queryService: IQueryService
	private var url = "https://pryaniky.com/static/json/sample.json"
	private var listItems = PublishSubject<[String]>()
	
	
	init(model: MainListModel, queryService: IQueryService) {
		self.model = model
		self.queryService = queryService
	}
}

private extension MainListViewModel {
	func fetchDataModel() {
		if let url = URL(string: self.url) {
			self.queryService.dataFrom(url: url).subscribe(onNext: { listModel in
//				print(listModel)
				if let data = listModel.view {
					self.listItems.onNext(data)
					self.listItems.onCompleted()
				}
				
			})
		}
	}
}

// MARK: IMainViewViewModelInput

extension MainListViewModel: IMainListViewModelInput {
	func fetchData() {
		self.fetchDataModel()
	}
	
	var list: PublishSubject<[String]> {
		get {
			self.listItems
		}
	}
}
