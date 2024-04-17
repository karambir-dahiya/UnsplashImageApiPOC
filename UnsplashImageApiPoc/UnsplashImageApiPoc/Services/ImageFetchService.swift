//
//  ImageFetchService.swift
//  UnsplashImageApiPoc
//
//  Created by Karambir on 15/04/24.
//

import Foundation


// Service call
class ImageFetchService {
	class func getData(completionHandler: (([ImageDataModel]) -> Void)?) {
		
		NetworkManager.shared.requestForApi(url: APIUrls.fetchImageUrl, completionHandler: { json, data in
			print(json)
			guard let data = data else {
				print("Err: No Respoonse")
				return
			}
			do {
				let decoder = try JSONDecoder().decode([ImageDataModel].self, from: data)
				guard let details = decoder as? [ImageDataModel] else {
					print("Err: Failed to parse data")
					return
				}
				completionHandler?(details)
			} catch let error as Error {
				print(String(describing: error))
			}
		}, errorHandler: { err in
			print("Recieved err: \(err)")
		})
	}
}

