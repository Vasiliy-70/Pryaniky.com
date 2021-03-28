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
			self.customView.label = item?.data?.text
			
			if let selectedId = item?.data?.selectedId {
				self.customView.sliderValue = Float(selectedId)
			} else {
				self.customView.sliderValue = nil
			}
			
			self.customView.imageURL = item?.data?.url
			
		}).disposed(by: self.disposeBag)
//		self.customView.addSubview(<#T##view: UIView##UIView#>)
	}
}
