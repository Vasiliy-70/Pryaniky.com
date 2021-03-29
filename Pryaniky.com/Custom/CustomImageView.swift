//
//  CustomImageView.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 29.03.2021.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
	private var spinner = UIActivityIndicatorView(style: .large)
	private var queryService: IQueryService
	
	init(queryService: IQueryService) {
		self.queryService = queryService
		super.init(image: UIImage())
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CustomImageView {
	func loadImage(from url: URL) {
		self.image = nil
		
		self.addSpinner()
		
		if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
			self.image = imageFromCache
			self.removeSpinner()
			return
		}
		
		self.queryService.getDataAt(url: url, completion: { (data, error) in
			guard let newImage = UIImage(data: data) else { return }
			imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
			
			DispatchQueue.main.async {
				self.image = newImage
				self.removeSpinner()
			}
		})
	}
}

private extension CustomImageView {
	func addSpinner() {
		self.addSubview(self.spinner)
		
		self.spinner.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			self.spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
		
		self.spinner.startAnimating()
	}
	
	func removeSpinner() {
		self.spinner.removeFromSuperview()
	}
}

