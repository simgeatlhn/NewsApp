//
//  Service.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import Alamofire

protocol ServiceProtocol: AnyObject {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void)
}

final class Service: ServiceProtocol {
    
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Network.ServiceEndPoint.fetchArticles()) { (response: ArticleList) in
            onSuccess(response)
            
        } onError: { error in
            onError(error)
        }
    }
    
}
