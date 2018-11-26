//
//  ContainerViewController.swift
//  PageView-Scroll-Sample
//
//  Created by kawaharadai on 2018/11/27.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class ContainerViewController: UIViewController {

    @IBOutlet weak var pageControll: UIPageControl!
    weak var pageVC: PageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // セグエで繋がっているVCを取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pageVC = segue.destination as? PageViewController, segue.identifier == "EmbedPageVC" else {
            return
        }
        self.pageVC = pageVC
        self.pageVC.pageViewDelegate = self
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        guard let currentPageTag = pageVC.viewControllers?[0].view.tag else { return }
        guard (pageVC.allPageCount - 1) > currentPageTag else {
            // 最終ページ表示中なら閉じる
            dismiss(animated: true, completion: nil)
            return
        }
        // ページコントロールの更新
        pageControll.currentPage = currentPageTag + 1
        // 表示中のページが最終ページ以外なら進める
        pageVC.setViewControllers([pageVC.vcArray[currentPageTag + 1]], direction: .forward, animated: true, completion: nil)
    }
    
}

extension ContainerViewController: PageViewDelegate {
    
    func updateCurrentPage(currenPage: Int?) {
        guard let currentPage = currenPage else { return }
        DispatchQueue.main.async {
            self.pageControll.currentPage = currentPage
        }
    }
    
}
