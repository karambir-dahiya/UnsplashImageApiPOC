//
//  ImageDataModel.swift
//  UnsplashImageApiPoc
//
//  Created by Karambir on 15/04/24.
//

import Foundation

// MARK: - WelcomeElement
struct ImageDataModel: Codable {
	
	let id: String
	let width, height: Int
	let color: String
	let description: String?
	let altDescription: String
	let urls: Urls
	
	enum CodingKeys: String, CodingKey {
		case id
		case width, height, color
		case description
		case altDescription = "alt_description"
		case urls
	}
}

// MARK: - Urls
struct Urls: Codable {
	let raw, full, regular, small: String
	let thumb, smallS3: String
	
	enum CodingKeys: String, CodingKey {
		case raw, full, regular, small, thumb
		case smallS3 = "small_s3"
	}
}
