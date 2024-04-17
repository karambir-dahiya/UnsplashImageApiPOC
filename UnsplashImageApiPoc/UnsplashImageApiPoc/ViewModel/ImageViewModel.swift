//
//  ImageViewModel.swift
//  UnsplashImageApiPoc
//
//  Created by Karambir on 15/04/24.
//

import Foundation

class ImageViewModel: ObservableObject {
	
	@Published	var images = [ImageDataModel]()
	@Published var showsAlert: Bool = false
	init() {
		ImageFetchService.getData { [weak self] data in // API Response
			guard var imagesData = data as? [ImageDataModel] else {
				self?.showsAlert = true
				return
			}
			self?.images = imagesData
		}
	}
	
}
	
