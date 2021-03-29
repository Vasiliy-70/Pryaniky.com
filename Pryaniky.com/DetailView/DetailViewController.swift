//
//  DetailViewController.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 25.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
	private var customView = DetailView()
	private var viewModel: MainListViewModel
	private var disposeBag = DisposeBag()
	
	init(viewModel: MainListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupViewData()
    }
	
	override func loadView() {
		self.view = customView
	}
}

extension DetailViewController {
	func setupViewData() {
		self.viewModel.item.subscribe(onNext: { item in
			self.navigationItem.title = item?.name
			
			let stack = UIStackView()
			stack.axis = .vertical
			stack.distribution = .equalSpacing
			stack.spacing = 50
			stack.alignment = .center
			
			if let text = item?.data?.text {
				stack.addArrangedSubview(Factory.singleton.create(ui: .label(text)))
			}
			
			if let url = item?.data?.url {
				stack.addArrangedSubview(Factory.singleton.create(ui: .imageView(url)))
			}
			
			self.customView.stack = stack
			
		}).disposed(by: self.disposeBag)
	}
}
