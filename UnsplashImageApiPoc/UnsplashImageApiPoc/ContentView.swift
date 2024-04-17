//
//  ContentView.swift
//  UnsplashImageApiPoc
//
//  Created by Karambir on 15/04/24.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var viewModel = ImageViewModel()
	@StateObject var imageCaching = ImageCaching()
	
	var body: some View {
		NavigationView {
			ScrollView {
				LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 2) {
					ForEach(viewModel.images, id: \.id) { image in
						VStack {
							NavigationLink(destination:ImageDetailView(imageData: image)) {
								let downloadedImage = imageCaching[image.urls.thumb]
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
											.cornerRadius(10)
									} else {
										Image(systemName: "exclamationmark.triangle")
											.foregroundColor(Color.red)
											.frame(width: 100, height: 100)
									}
								}
								
							}
						}
					}
				}
			}
		}
		.alert(isPresented: $viewModel.showsAlert) {
			Alert(title: Text("Error Encountered in API"))
		}
	}
}

#Preview {
	ContentView()
}
