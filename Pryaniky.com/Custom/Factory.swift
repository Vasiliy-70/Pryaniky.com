//
//  Factory.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 29.03.2021.
//

import UIKit

enum UIElement {
	case label(String)
	case imageView(String)
}

final class Factory {
	static let singleton = Factory(queryService: QueryService())
	private var queryService: IQueryService
	
	private init(queryService: IQueryService) {
		self.queryService = queryService
	}
	
	func create(ui: UIElement) -> UIView {
		switch ui {
		case .label(let text):
			let label = UILabel()
			label.text = text
			return label
		case .imageView(let url):
			let imageView = CustomImageView(queryService: self.queryService)
			if let url = URL(string: url) {
				imageView.loadImage(from: url)
			}
			return imageView
		}
	}
}
