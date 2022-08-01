//
//  ArticleHomeViewController.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import UIKit
import SnapKit

protocol ArticleOutPut {
    func articles(article: Article)
}

final class ArticleController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var viewModel: ArticleViewModelProtocol
    
    init(viewModel: ArticleViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        drawDesign()
        makeTableView()
        fetchData() //**
    }
    
    func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        title = "News"
    }
}


// MARK: - TableView Extensions
extension ArticleController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
        
    }
}


extension ArticleController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.snp.top).inset(100)
        }
    }
}

// MARK: - Service Extension
private extension ArticleController {
    private func fetchData() {
        viewModel.fetchArticles { [weak self] data in
            guard let data = data?.articles else { return }
            self?.viewModel.articles = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } onError: { error in
            print(error)
        }
    }
}

