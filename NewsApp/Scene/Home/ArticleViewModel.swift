//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import Alamofire

protocol ArticleViewModelProtocol: AnyObject {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void)
    
    var articles: [Article] { get set }
    var delegate: ArticleOutPut? { get set }

}

final class ArticleViewModel: ArticleViewModelProtocol {
    
    var delegate: ArticleOutPut?
    var articles = [Article]()
    
    var service: ServiceProtocol
    
    init(service: ServiceProtocol){
        self.service = service
    }
}

// MARK: - Service
extension ArticleViewModel {
    func fetchArticles(onSuccess: @escaping (ArticleList?) -> Void, onError: @escaping (AFError) -> Void) {
        service.fetchArticles { data in
            guard let model = data else { onSuccess(nil)
                return
            }
            onSuccess(model)
        } onError: { error in
            onError(error)
        }
    }
}
