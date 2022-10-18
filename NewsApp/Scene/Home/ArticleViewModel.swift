//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import Alamofire

protocol ArticleViewModelProtocol: AnyObject {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchDetailArticle(onSuccess: @escaping (Article?) -> Void, onError: @escaping (AFError) -> Void)
}

final class ArticleViewModel: ArticleViewModelProtocol {
    var service: ServiceProtocol
    
    init(service: ServiceProtocol){
        self.service = service
    }
    
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void) {
        service.fetchArticles { article in
            guard let article = article else {
                onSuccess(nil)
                return
            }
            onSuccess(article)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchDetailArticle(onSuccess: @escaping (Article?) -> Void, onError: @escaping (AFError) -> Void) {
        service.fetchDetailArticle { article in
            guard let article = article else {
                onSuccess(nil)
                return
            }
            onSuccess(article)
        } onError: { error in
            onError(error)
        }
    }
}
