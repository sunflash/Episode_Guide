//
//  RemoteImage.swift
//  Episode_Guide
//
//  Created by Min Wu on 23/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation
import SwiftUI

struct RemoteImage: View {

    @State var image: UIImage? = nil

    private let url: String?
    private let height: CGFloat?
    private let width: CGFloat?
    private let placeholder: Image
    private let imageLoader = ImageLoader()

    init(url: String?,
         height: CGFloat? = nil,
         width: CGFloat? = nil,
         placeholder: Image = Image(systemName: "photo")
    ) {
        self.url = url
        self.height = height
        self.width = width
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            imageView
        }
        .onAppear(perform: {
            if let urlString = self.url, let url = URL(string: urlString) {
                 self.imageLoader.load(url: url)
            }
        })
        .onDisappear(perform: {
            self.imageLoader.cancel()
        })
        .onReceive(imageLoader.imageReceive, perform: { image in
            self.image = image
        })
    }

    private func getImage() -> Image {
        guard let image = image else {
            return placeholder
        }
        return Image(uiImage: image)
    }

    private var imageView: some View {
        if width != nil || height != nil {
            return AnyView(
                getImage()
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
            )
        } else {
            return AnyView(getImage().resizable().aspectRatio(contentMode: .fit))
        }
    }
}
