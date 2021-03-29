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
	var stack: UIStackView { get set }
}

final class DetailView: UIView {
	private var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.backgroundColor = .white
		return scrollView
	}()
	
	private var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.alignment = .center
		return stackView
	}()
	
	private enum Constraints {
		static let verticalOffset: CGFloat = 20
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension DetailView {
	func setupView() {
		self.backgroundColor = .white
		self.setupConstraints()
	}
	
	func setupConstraints() {
		self.addSubview(self.scrollView)
		self.scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			self.scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			self.scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
		])
		
		self.scrollView.addSubview(self.stackView)
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: Constraints.verticalOffset),
			self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
		])
	}
}

// MARK: IDetailViewType

extension DetailView: IDetailViewType {
	var stack: UIStackView {
		get {
			self.stackView
		}
		set {
			self.stackView = newValue
			self.setupConstraints()
			self.layoutIfNeeded()
		}
	}
}
