//
//  PageViewController.swift
//  PageView-Scroll-Sample
//
//  Created by kawaharadai on 2018/11/26.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

protocol PageViewDelegate: class {
    /// ページング毎にページコントロールを更新する
    ///
    /// - Parameter currenPage: 現在表示しているページ番号
    func updateCurrentPage(currenPage: Int?)
}

final class PageViewController: UIPageViewController {
    
    var vcArray = [PartsViewController]()
    weak var pageViewDelegate: PageViewDelegate?
    let allPageCount = 4
    let colorArray: [UIColor] = [.red, .blue, .green, .yellow]
    
    // 表示用のデータ（所々トルツメ確認のため空欄にしています）
    let idArray = ["Austraria-000000000000000000000000",
                   "",
                   "",
                   ""]
    let imageViewNameArray = ["austraria", "bari", "guam", "vietnam"]
    let titleArray = ["オーストラリア", "", "グアム", "ベトナム"]
    let titleTextArray = ["オーストラリア連邦（オーストラリアれんぽう、英語: Commonwealth of Australia）、またはオーストラリア（Australia）",
                          "バリ島（インドネシア語: Pulau Bali）は、東南アジアのインドネシア共和国バリ州に属する島である。",
                          "グアム（英語: Guam, チャモロ語: Guåhån）は、太平洋にあるマリアナ諸島南端の島。",
                          "ベトナムは、東南アジアのインドシナ半島東部に位置する社会主義共和国。首都はハノイ。"]
    let subTitleTextArray = ["総面積は世界第6位である。近隣諸国としては、北にパプアニューギニア・インドネシア・東ティモール、北東にソロモン諸島・バヌアツ、東はトンガ・ニューカレドニア・フィジー、南東2,000km先にニュージーランドがある。2014年、同国の一人当たりの国民所得は世界第5位であった。",
                             "首都ジャカルタがあるジャワ島のすぐ東側に位置し、周辺の諸島と共に第一級地方自治体(Provinsi)であるバリ州を構成する。2014年の島内人口は約422万人である。",
                             "マリアナ諸島最大の島で、その南西端に位置する。海底火山によって造られた。北部は珊瑚礁に囲まれた石灰質の平坦な台地で、南部は火山の丘陵地帯である。最高所はラムラム山で標高406m。",
                             ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setupViewControllers()
        setViewControllers([vcArray[0]], direction: .forward, animated: false, completion: nil)
    }
    
    func setupViewControllers() {
        // 同じVCを使い回すためにfor文で用意
        for i in 0 ..< allPageCount {
            let partsVC = PartsViewController.make()
            partsVC.view.tag = i
            partsVC.view.backgroundColor = colorArray[i]
            vcArray.append(partsVC)
        }
        // それぞれのVCに表示データを渡す
        setViewControllersData(vcArray: vcArray)
    }
    
    func setViewControllersData(vcArray: [PartsViewController]) {
        for (i, value) in vcArray.enumerated() {
            value.setViewData(id: idArray[i],
                              imageViewName: imageViewNameArray[i],
                              title: titleArray[i],
                              titleText: titleTextArray[i],
                              subTitleText: subTitleTextArray[i])
        }
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    
    // 左スワイプ
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let nextPageCount = viewController.view.tag + 1
        // 最終ページかどうか
        let isLastPage = nextPageCount >= allPageCount
        pageViewDelegate?.updateCurrentPage(currenPage: isLastPage ? nextPageCount : nextPageCount - 1)
        return isLastPage ? nil : vcArray[nextPageCount]
    }
    
    // 右スワイプ
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let nextPageCount = viewController.view.tag - 1
        // 最初のページかどうか
        let isFirstPage = 0 > nextPageCount
        pageViewDelegate?.updateCurrentPage(currenPage: isFirstPage ? nextPageCount : nextPageCount + 1)
        return isFirstPage ? nil : vcArray[nextPageCount]
    }
    
}
