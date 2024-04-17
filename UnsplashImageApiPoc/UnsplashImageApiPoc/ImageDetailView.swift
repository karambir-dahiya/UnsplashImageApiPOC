//
//  ImageDetailView.swift
//  UnsplashImageApiPoc
//
//  Created by Karambir on 16/04/24.
//

import SwiftUI

struct ImageDetailView: View {
	
	var imageData: ImageDataModel?
	@StateObject var imageCaching = ImageCaching()
	
	var body: some View {
		VStack {
			let downloadedImage = imageCaching[imageData?.urls.full ?? ""]
			switch downloadedImage.0 {
			case .processing:
				ProgressView()
					.frame(width: 100, height: 100)
			case .failed:
				Image(systemName: "exclamationmark.triangle")
					.foregroundColor(Color.red)
					.frame(width: 100, height: 100)
			case .success:
				if let validImage = downloadedImage.1 {
					validImage
						.resizable()
						.scaledToFit()
				} else {
					Image(systemName: "exclamationmark.triangle")
						.foregroundColor(Color.red)
						.frame(width: 100, height: 100)
				}
			}
		}
	}
}
