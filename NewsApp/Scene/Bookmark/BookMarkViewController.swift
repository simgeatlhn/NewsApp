//
//  BookMarkViewController.swift
//  NewsApp
//
//  Created by simge on 1.08.2022.
//

import UIKit
import SnapKit
import Lottie

class BookMarkViewController: UIViewController {
    
    private var animation = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        makeAnimation()
    }
    
    private func configure() {
        drawDesing()
        
        view.addSubview(animation)
    }
    
    private func drawDesing() {
        title = "Bookmark".localize()
        view.backgroundColor = UIColor(red: 15/255, green: 61/255, blue: 62/255, alpha: 1)
        
        animation = .init(name: "news")
        animation.frame = view.bounds
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animationSpeed = 2
        animation.play()
        
    }
}

extension BookMarkViewController {
    private func makeAnimation() {
        animation.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(120)
            make.right.equalTo(view.snp.right).offset(-8)
            make.left.equalTo(view.snp.left).offset(8)
        }
    }
}
