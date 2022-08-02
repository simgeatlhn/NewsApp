//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by simge on 2.08.2022.
//

import UIKit
import SnapKit
import Lottie

class ArticleDetailViewController: UIViewController {
    
    private var animation = AnimationView()
    
    private let detailTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 5
        title.font = .boldSystemFont(ofSize: 16)
        title.textColor =  UIColor(red: 205/255, green: 190/255, blue: 120/255, alpha: 1)
        return title
    }()
    
    private let overview: UILabel = {
        let overView = UILabel()
        overView.numberOfLines = 30
        overView.textColor = .white
        return overView
    }()
    
    private let favouriteIcon : UIButton = {
        let favouriteIcon = UIButton()
        favouriteIcon.setImage(UIImage(systemName: "bookmark"), for: .normal)
        favouriteIcon.tintColor = .white
        return favouriteIcon
    }()
    
    private let articleImage: UIImageView = {
        let articleImage = UIImageView()
        articleImage.layer.cornerRadius = 8
        articleImage.clipsToBounds = true
        return articleImage
    }()
    
    //***
    private let articles: Article
    
    init(article: Article) {
        self.articles = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        saveArticleDetail()
        
        makeDetailTitle()
        makeOverview()
        makeImage()
        makeFavouriteIcon()
        makeAnimation()
    }
    
    func configure() {
        drawDesign()
        
        view.addSubview(detailTitle)
        view.addSubview(overview)
        view.addSubview(articleImage)
        view.addSubview(favouriteIcon)
        view.addSubview(animation)
    }
    
    func drawDesign() {
        title = "Details"
        view.backgroundColor = UIColor(red: 15/255, green: 61/255, blue: 62/255, alpha: 1)
        
        animation = .init(name: "news")
        animation.frame = view.bounds
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animationSpeed = 1
        animation.play()
    }
    
    private func saveArticleDetail() {
        detailTitle.text = articles.title
        overview.text = articles.content
        articleImage.kf.setImage(with: URL(string: articles.urlToImage!)!)
    }
}

extension ArticleDetailViewController {
    private func makeDetailTitle() {
        detailTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(140)
            make.left.equalTo(view.snp.left).offset(16)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-10)
        }
    }
    
    private func makeOverview() {
        overview.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(articleImage).offset(210)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
        }
    }
    
    private func makeImage(){
        articleImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(detailTitle.snp.top).offset(80)
            make.width.equalTo(380)
            make.height.equalTo(240)
        }
    }
    
    private func makeFavouriteIcon() {
        favouriteIcon.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(100)
            make.right.equalTo(view.snp.right).offset(-20)
        }
    }
    
    private func makeAnimation() {
        animation.snp.makeConstraints { (make) in
            make.top.equalTo(overview.snp.top).offset(24)
            make.right.equalTo(view.snp.right).offset(-8)
            make.left.equalTo(view.snp.left).offset(8)
        }
    }
}
