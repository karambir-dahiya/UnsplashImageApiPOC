//
//  NetworkHandle.swift
//  UnsplashImageApiPoc
//
//  Created by Karambir on 15/04/24.
//

import Foundation

enum APIRequestMethod: String {
	case get = "GET"
	case post = "POST"
}

class NetworkManager {
	static let shared = NetworkManager()
	
	func requestForApi(url: String, requestMethod: APIRequestMethod = .get, completionHandler: ((Any, Data?)->())? = nil, errorHandler: ((Any)->())? = nil) {
		var request = URLRequest(url: URL(string: url)!)
		request.httpMethod = requestMethod.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		let session = URLSession.shared
		session.dataTask(with: request) {data, response, err in
			if let err = err {
				print("Received some error in api \(err.localizedDescription)")
				DispatchQueue.main.async {
					errorHandler?(err)
				}
				return
			}
			guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else {
				print("Getting some error on json Serialization")
				DispatchQueue.main.async {
					errorHandler?(err)
				}
				return
			}
			DispatchQueue.main.async {
				completionHandler?(jsonData, data!)
			}
		}.resume()
	}
}

