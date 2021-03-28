//
//  DetailView.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 25.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol IDetailViewType: class {
	var label: String? { get set }
	var imageURL: String? { get set }
	var sliderValue: Float? { get set }
}

final class DetailView: UIView {
	private var textLabel: UILabel = {
		let text = UILabel()
		text.font = .systemFont(ofSize: 14)
		text.text = "Default"
		return text
	}()
	
	private var imageView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	private var slider: UISlider = {
		let slider = UISlider()
		slider.value = 0
		return slider
	}()
	
	private enum Constants {
		static let elementSpacing: CGFloat = 10
		static let sliderWidth: CGFloat = 100
	}
	
	private enum ActiveConstraints {
		static var imageViewConstraints: [NSLayoutConstraint] = []
		static var textLabelConstraints: [NSLayoutConstraint] = []
		static var sliderConstraints: [NSLayoutConstraint] = []
	}
	
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension DetailView {
	func setupView() {
		self.backgroundColor = .gray
		self.setupConstraints()
	}
	
	func setupConstraints() {
		self.addSubview(self.textLabel)
		self.textLabel.translatesAutoresizingMaskIntoConstraints = false
		
		ActiveConstraints.textLabelConstraints.append(contentsOf: [
			self.textLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.elementSpacing),
			self.textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
		
		self.addSubview(self.slider)
		self.slider.translatesAutoresizingMaskIntoConstraints = false
		
		ActiveConstraints.sliderConstraints.append(contentsOf: [
			self.slider.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor, constant: Constants.elementSpacing),
			self.slider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.slider.widthAnchor.constraint(equalToConstant: Constants.sliderWidth)
		])
	}
}

// MARK: IDetailViewType

extension DetailView: IDetailViewType {
	var label: String? {
		get {
			self.textLabel.text
		}
		set {
			if newValue != nil {
				self.textLabel.text = newValue
				NSLayoutConstraint.activate(ActiveConstraints.textLabelConstraints)
			} else {
				NSLayoutConstraint.deactivate(ActiveConstraints.textLabelConstraints)
			}
			self.layoutIfNeeded()
		}
	}
	
	var imageURL: String? {
		get {
			""
		}
		set {
//
		}
	}
	
	var sliderValue: Float? {
		get {
			return self.slider.value
		}
		set {
			if let value = newValue  {
				self.slider.setValue(value, animated: true)
				NSLayoutConstraint.activate(ActiveConstraints.sliderConstraints)
			} else {
				NSLayoutConstraint.deactivate(ActiveConstraints.sliderConstraints)
			}
			self.layoutIfNeeded()
	   }
	}
	
}
