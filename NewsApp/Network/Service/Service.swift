//
//  Service.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import Foundation
import Alamofire

// MARK: - Service Protocol
protocol ServiceProtocol {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchDetailArticle(onSuccess: @escaping (Article?) -> Void, onError: @escaping (AFError) -> Void)
}

// MARK: - Services
final class Service: ServiceProtocol {
    
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Network.ServiceEndPoint.fetchArticles()) { (response: ArticleList) in
            onSuccess(response)
            
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchDetailArticle(onSuccess: @escaping (Article?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Network.ServiceEndPoint.fetchArticles()) { (response: Article) in
            onSuccess(response)
            
        } onError: { error in
            onError(error)
        }
    }
}
