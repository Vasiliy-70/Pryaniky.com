//
//  AppCoordinator.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 21.03.2021.
//

import UIKit

final class AppCoordinator {
	private let window: UIWindow
	
	init(window: UIWindow) {
		self.window = window
	}
	
	func start() {
		let model = MainListModel(data: nil, view: nil)
		let viewModel = MainListViewModel(model: model, queryService: QueryService())
		let viewController = MainListViewController(viewModel: viewModel)
		let navigationController = UINavigationController(rootViewController: viewController)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}
