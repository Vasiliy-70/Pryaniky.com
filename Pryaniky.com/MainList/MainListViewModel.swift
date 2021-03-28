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
	var item: BehaviorSubject<RootData?> { get }
}

protocol IMainListViewModelOutput: class {
//	Выходной протокол
	var selectedItemName: String { get set }
}

final class MainListViewModel {
	private var model: MainListModel
	private var queryService: IQueryService
	private var url = "https://pryaniky.com/static/json/sample.json"
	private var listItems = PublishSubject<[String]>()
	private var selectedItems = BehaviorSubject<RootData?>(value: nil)
	private var listItemsData = [RootData]()
	private let disposeBag = DisposeBag()
	
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
				
				self.listItemsData = listModel.data ?? []
			}).disposed(by: disposeBag)
		}
	}
}

// MARK: IMainViewViewModelInput

extension MainListViewModel: IMainListViewModelInput {
	var item: BehaviorSubject<RootData?> {
		self.selectedItems
	}
	
	func fetchData() {
		self.fetchDataModel()
	}
	
	var list: PublishSubject<[String]> {
		get {
			self.listItems
		}
	}
}

// MARK: IMainListViewModelOutput

extension MainListViewModel: IMainListViewModelOutput {
	var selectedItemName: String {
		get {
			return ""
		}
		set {
			for item in listItemsData{
				if item.name == newValue {
					self.selectedItems.onNext(item)
				}
			}
		}
	}
}
