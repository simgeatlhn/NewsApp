//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by simge on 2.08.2022.
//

import UIKit
import SnapKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    
    private let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 3
        title.font = .boldSystemFont(ofSize: 16)
        title.textColor = UIColor(red: 15/255, green: 61/255, blue: 62/255, alpha: 1)
        return title
    }()
    
    private let overview: UILabel = {
        let overView = UILabel()
        overView.numberOfLines = 5
        overView.preferredMaxLayoutWidth = 700
        overView.sizeToFit()
        return overView
    }()
    
    private let articleImage: UIImageView = {
        let articleImage = UIImageView()
        articleImage.layer.cornerRadius = 8
        articleImage.clipsToBounds = true
        return articleImage
    }()
    
    enum Identifier: String {
        case custom = "cell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func saveArticle(model: Article) {
        title.text = model.title
        overview.text = model.content
        articleImage.kf.setImage(with: URL(string: model.urlToImage!)!)
    }
    
    private func configure() {
        addSubview(title)
        addSubview(overview)
        addSubview(articleImage)
        
        makeTitleLabel()
        makeOverviewLabel()
        makeImage()
    }
}


extension ArticleTableViewCell {
    private func makeTitleLabel() {
        title.snp.makeConstraints { (make) in
            make.top.equalTo(overview.snp.top).offset(10)
            make.left.equalToSuperview().offset(150)
            make.right.equalTo(overview.snp.right).offset(-8)
        }
    }
    
    private func makeOverviewLabel() {
        overview.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(150)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(title.snp.bottom).offset(180)
        }
    }
    private func makeImage(){
        articleImage.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(120)
            make.height.equalTo(180)
        }
    }
}
