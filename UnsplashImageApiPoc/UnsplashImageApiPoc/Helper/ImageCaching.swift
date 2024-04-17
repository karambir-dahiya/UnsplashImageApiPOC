//
//  ImageCaching.swift
//  UnsplashImageApiPoc
//
//  Created by Karambir on 17/04/24.
//

import Foundation
import SwiftUI

enum ImageState {
	case processing
	case failed
	case success
}
class ImageCaching: ObservableObject {
	@Published var internalCache: [String: (ImageState, Image?)] = [:]
	
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
	
	func downloadImage(from url: String) {
		DispatchQueue.global(qos: .userInteractive).async {
			if let validUrl = URL(string: url) {
				setImageState(.processing)
				print("Download Started")
				self.getData(from: validUrl) { data, response, error in
					guard let data = data, error == nil else {
						setImageState(.failed)
						return
					}
					guard let uiImage = UIImage(data: data) else {
						setImageState(.failed)
						return
					}
					DispatchQueue.main.async {
						self.internalCache[url] = (.success, Image(uiImage: uiImage))
					}
				}
			} else {
				setImageState(.failed)
			}
		}
		func setImageState(_ imageState: ImageState) {
			DispatchQueue.main.async {
				self.internalCache[url] = (imageState, nil)
			}
		}
	}
}

extension ImageCaching {
	subscript(url: String) -> (ImageState, Image?) {
		get {
			if let image = self.internalCache[url] {
				return image
			} else {
				self.downloadImage(from: url)
				return (.processing, nil)
			}
		}
	}
}

