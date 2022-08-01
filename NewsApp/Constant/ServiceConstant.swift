//
//  ServiceConstant.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import Foundation

class Network {
    
    enum ServiceEndPoint: String {
        
        case BASE_URL = "https://newsapi.org/v2/everything?q=bitcoin&"
        case API_KEY = "apiKey=605d43c6493943378e74fc65a199de52"
        
        static func fetchArticles() -> String {
            "\(ServiceEndPoint.BASE_URL.rawValue)\(ServiceEndPoint.API_KEY.rawValue)"
        }
    }
}

