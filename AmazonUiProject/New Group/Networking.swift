//
//  NetworkLayer.swift
//  AmazonUiProject
//
//  Created by Vijay Lal on 24/09/24.
//

import Foundation
class Networking {
    func getAllproduct(url: String, completion: @escaping(Data?, Bool) -> Void) {
        guard let unwrappedurl = URL(string: url) else { return }
        let request = URLRequest(url: unwrappedurl)
        URLSession.shared.dataTask(with: request) { urlData, urlResponce, _ in
            if let URLData = urlData {
                completion(URLData, true)
            } else {
                completion(nil ,false)
            }
        }.resume()
    }
}
