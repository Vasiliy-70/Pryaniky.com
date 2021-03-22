//
//  MainListView.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 21.03.2021.
//

import UIKit

protocol IMainListViewType: class {
	var tableView: UITableView { get }
//	var labelText: String? { get set }
}

final class MainListView: UIView {
	private weak var viewController: MainListViewController?
	private var listItems = UITableView()
	
	init(viewController: MainListViewController) {
		self.viewController = viewController
		super.init(frame: .zero)
		
		
		self.setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: SetupConstraints

extension MainListView {
	func setupView() {
		self.backgroundColor = .red
		self.setupListItems()
	}
	
	func setupListItems() {
		self.addSubview(self.listItems)
		self.listItems.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.listItems.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			self.listItems.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			self.listItems.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			self.listItems.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

// MARK: IMainListViewType

extension MainListView: IMainListViewType {
	var tableView: UITableView {
		self.listItems
	}
}
