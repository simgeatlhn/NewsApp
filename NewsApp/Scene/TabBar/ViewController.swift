//
//  ViewController.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        drawDesign()
    }
    
    func drawDesign() {
        //view.backgroundColor = .red
        
    }
    
    func configure() {
        let service = Service()
        let viewModel: ArticleViewModel = ArticleViewModel(service: service)
        _ = ArticleController(viewModel: viewModel)
        
        let vc1 = UINavigationController(rootViewController: ArticleController(viewModel: viewModel))
        let vc2 = UINavigationController(rootViewController: BookMarkViewController())
        
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor =  .systemBackground
        
        self.setViewControllers([vc1, vc2], animated: false)
        
        guard let items = self.tabBar.items else { return }
        let images = ["newspaper","bookmark"]
        for item  in 0..<items.count {
            items[item].image = UIImage(systemName: images[item])
        }
    }
    
}
