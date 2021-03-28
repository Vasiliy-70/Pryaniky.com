//
//  MainListViewController.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 21.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class MainListViewController: UIViewController {
	private var viewModel: MainListViewModel
	private var customView: IMainListViewType?
	
	private let disposeBag = DisposeBag()
	private let cellId = "cellId"
	
	init(viewModel: MainListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		self.customView = MainListView(viewController: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = customView as? UIView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupTable()
	}
}

extension MainListViewController {
	func loadViewData() {
//		self.viewModel.fetchData().subscribe(onNext: { text in
//			DispatchQueue.main.async {
////				self.customView?.labelText = text
//			}
//		}).disposed(by: self.disposeBag)
	}
	
	func setupTable() {
		guard let tableView = self.customView?.tableView else { return }
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
		tableView.delegate = self
		
		self.viewModel.list.bind(to: tableView.rx.items(cellIdentifier: self.cellId, cellType: UITableViewCell.self)) { (row, item, cell) in
			cell.textLabel?.text = item
		}.disposed(by: disposeBag)
		
		tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
			print("SelectedItem: \(item)")
			self.viewModel.selectedItemName = item
		}).disposed(by: disposeBag)
		
		self.viewModel.fetchData()
	}
}

// MARK: UITableViewDelegate

extension MainListViewController: UITableViewDelegate {
}

// MARK: UITableViewDataSource
//
//extension MainListViewController: UITableViewDataSource {
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		<#code#>
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		<#code#>
//	}
//
//
//}
