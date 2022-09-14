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

class ArticleController: UIViewController {
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 200
        return tableView
    }()
    
    private var searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
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
        navigationItem.searchController = searchController
        configure()
    }
    
    func configure() {
        drawDesign()
        fetchData() //**
        makeTableView()
    }
    
    func drawDesign() {
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.Identifier.custom.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        title = "News".localize()
    }
}

//MARK: - Localization
extension String {
    func localize() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}


// MARK: - TableView Extensions
extension ArticleController:ConfigureTableView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.Identifier.custom.rawValue) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.saveArticle(model: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ArticleDetailViewController(article: viewModel.articles[indexPath.row])
        show(vc, sender: self)
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

