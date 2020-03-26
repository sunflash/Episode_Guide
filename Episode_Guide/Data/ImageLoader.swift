//
//  ImageLoader.swift
//  Episode_Guide
//
//  Created by Min Wu on 22/03/2020.
//  Copyright © 2020 sunflash. All rights reserved.
//

import Foundation
import Combine
import UIKit

class ImageLoader: ObservableObject {
    
    private var cancellable: AnyCancellable?
    let imageReceive = PassthroughSubject<UIImage?, Never>()

    func load(url: URL) {
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map({UIImage(data: $0.data)})
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] image in
                self?.imageReceive.send(image)
            })
    }

    func cancel() {
        cancellable?.cancel()
    }
}
