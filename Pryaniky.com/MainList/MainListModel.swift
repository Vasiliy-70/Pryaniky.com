//
//  MainListModel.swift
//  Pryaniky.com
//
//  Created by Боровик Василий on 21.03.2021.
//

import Foundation

struct MainListModel: Codable {
	let data: [RootData]?
	let view: [String]?
}

struct RootData: Codable {
	let name: String?
	let data: ObjectData?
}

struct ObjectData: Codable {
	let text: String?
	let url: String?
	let selectedId: Int?
	let variants: [Variants]?
}

struct Variants: Codable {
	let id: Int?
	let text: String?
}

/*
{
	"data": [{
			"name": "hz",
			"data": {
				"text": "Текстовый блок"
			}
		}, {
			"name": "picture",
			"data": {
				"url": "https://pryaniky.com/static/img/logo-a-512.png",
				"text": "Пряники"
			}
		}, {
			"name": "selector",
			"data": {
				"selectedId": 1,
				"variants": [{
						"id": 1,
						"text": "Вариант раз"
					}, {
						"id": 2,
						"text": "Вариант два"
					}, {
						"id": 3,
						"text": "Вариант три"
					}
				]
			}
		}
	],
	"view": ["hz", "selector", "picture", "hz"]
}
*/
