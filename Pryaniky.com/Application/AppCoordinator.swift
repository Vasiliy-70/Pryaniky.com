//
//  AppCoordinator.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 21.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class AppCoordinator {
	private let window: UIWindow
	private let disposeBag = DisposeBag()
	
	private var navigationController: UINavigationController?
	private var detailView: DetailViewController?
	
	init(window: UIWindow) {
		self.window = window
	}
	
	func start() {
		let model = MainListModel(data: nil, view: nil)
		let viewModel = MainListViewModel(model: model, queryService: QueryService())
		let viewController = MainListViewController(viewModel: viewModel)
		self.navigationController = UINavigationController(rootViewController: viewController)
		
		viewModel.item.subscribe(onNext: { item in
			if item != nil {
				self.changeView(DetailViewController(viewModel: viewModel))
			}
		}).disposed(by: disposeBag)
		
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
	
	func changeView(_ viewController: UIViewController) {
		guard let nc = self.navigationController else { return }
		if !nc.viewControllers.contains(viewController) {
			nc.pushViewController(viewController, animated: true)
		}
	}
}
