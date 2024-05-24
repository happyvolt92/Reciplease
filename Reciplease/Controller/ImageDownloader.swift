//
//  ImageDownloader.swift
//  Reciplease
//
//  Created by HappyVolt on 20/05/2024.

//

import Foundation
import UIKit
 
class ImageDownloader {
  static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        print("Failed to fetch image data: \(error?.localizedDescription ?? "No error description")")
        completion(nil)
        return
      }
      
      DispatchQueue.main.async {
        completion(UIImage(data: data))
      }
    }
    task.resume()
  }
}
