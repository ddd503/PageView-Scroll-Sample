//
//  PartsViewController.swift
//  PageView-Scroll-Sample
//
//  Created by kawaharadai on 2018/11/26.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class PartsViewController: UIViewController {
    
    // インスタンス作成
    class func make() -> PartsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let partsVC = storyboard.instantiateViewController(withIdentifier: PartsViewController.identifier) as? PartsViewController else {
            fatalError("VCのインスタンス化に失敗")
        }
        return partsVC
    }
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var subTitleTextView: UITextView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setViewData(id: String,
                     imageViewName: String,
                     title: String,
                     titleText: String,
                     subTitleText: String) {
        idLabel.text = id
        imageView.image = UIImage(named: imageViewName)!
        titleLabel.text = title
        titleTextView.text = titleText
        subTitleTextView.text = subTitleText
        // トルツメできないため消す
        subTitleTextView.isHidden = subTitleText.isEmpty
    }
    
}
