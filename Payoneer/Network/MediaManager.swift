//
//  MediaManager.swift
//  Payoneer
//
//  Created by fatih maytalman on 8.05.2021.
//

import UIKit.UIImage

enum MediaLoadingError: Error {

    case loadingError
}

final class MediaManager {

    static let shared = MediaManager()

    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    private var uuidMap = [URL: UUID]()

    func load(_ url: URL,
              uuid: UUID,
              completion: @escaping (Result<UIImage, MediaLoadingError>) -> (Void)) {
        uuidMap[url] = uuid

        if let loadedImage = loadedImages[url] {
            completion(.success(loadedImage))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            self.runningRequests.removeValue(forKey: uuid)

            guard let data = data,
                  error == nil,
                  let image = UIImage(data: data) else {
                if let error = error as NSError?, error.code != NSURLErrorCancelled {
                    completion(.failure(.loadingError))
                }
                return
            }
            self.loadedImages[url] = image
            completion(.success(image))
        }

        dataTask.resume()
        runningRequests[uuid] = dataTask
    }

    func cancel(for uuid: UUID?) {
        guard let uuid = uuid else { return }
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
