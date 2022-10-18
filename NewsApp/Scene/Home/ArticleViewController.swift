//
//  ArticleHomeViewController.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import UIKit
import SnapKit

protocol ArticleOutPut {
    func selectedArticles(article: Article)
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
    private var newsResult = [Article]()
    private var filteredResult = [Article]()
    
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
        searchController.searchResultsUpdater = self //***
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Articles"
        
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

// MARK: - TableView Extensions
extension ArticleController:ConfigureTableView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredResult.count
        }else {
            return newsResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.Identifier.custom.rawValue) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        if searchController.isActive {
            cell.saveArticle(model: filteredResult[indexPath.row])
        }else {
            cell.saveArticle(model: newsResult[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchController.isActive {
            selectedArticles(article: filteredResult[indexPath.row])
        }else {
            selectedArticles(article: newsResult[indexPath.row])
        }
    }
}


// MARK: - Table
extension ArticleController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.snp.top).inset(100)
        }
    }
}

// MARK: - Service Extension - Connection
private extension ArticleController {
    private func fetchData() {
        viewModel.fetchArticles { [weak self] data in
            guard let data = data?.articles else { return }
            self?.newsResult = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } onError: { error in
            print(error)
        }
    }
}

//MARK: - Navigation
extension ArticleController: ArticleOutPut {
    func selectedArticles(article: Article) {
        navigationController?.pushViewController(ArticleDetailViewController(article: article), animated: true)
    }
}

//MARK: - Searchable
extension ArticleController: UISearchResultsUpdating {
    
    func filterContentForSearchText(_ searchText: String) {
        filteredResult = newsResult.filter({ (newsResult:Article) -> Bool in
            let titleMatch = newsResult.title?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return titleMatch != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText.count > 2 {
                filterContentForSearchText(searchText)
                tableView.reloadData()
            }else {
                tableView.reloadData()
            }
        }
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

