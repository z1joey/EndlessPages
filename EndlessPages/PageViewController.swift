//
//  PageViewController.swift
//  EndlessPages
//
//  Created by joey on 3/27/20.
//  Copyright © 2020 TGI Technology. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var pages: [ViewController?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self

        for index in -1...1 {
            let vc = UIStoryboard.vc()
            vc?.index = index
            pages.append(vc)
        }

        if pages.indices.contains(1), let middlePage = pages[1] {
            setViewControllers([middlePage], direction: .forward, animated: false, completion: nil)
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let current = viewController as? ViewController else { return nil }
        guard var index = pages.firstIndex(of: current) else { return nil }

        index += 1

        if index == NSNotFound {
            return nil
        }

        // -1, 0, 1
        if index >= pages.count {
            // -1 becomes 2
            // pages.forEach { $0?.index += 3 }
            index = 0
        }

        // print(index)
        return pages[index]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        guard let current = viewController as? ViewController else { return nil }
        guard var index = pages.firstIndex(of: current) else { return nil }

        index -= 1

        if index == NSNotFound {
            return nil
        }

        // -1, 1, 0
        if index < 0 {
            // 0 becomes -2
            // pages.forEach { $0?.index -= 3 }
            index = pages.count - 1
        }

        // print(index)
        return pages[index]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.children.first as? ViewController else { return }
        guard let currentIndex = pages.firstIndex(of: currentVC) else { return }

        if completed {
            var lastIndex = currentIndex - 1
            var nextIndex = currentIndex + 1

            if lastIndex < 0 { lastIndex = 2 }
            if nextIndex > (pages.count - 1) { nextIndex = 0 }

            if pages.indices.contains(lastIndex) {
                pages[lastIndex]?.index = currentVC.index - 1
            }
            if pages.indices.contains(nextIndex) {
                pages[nextIndex]?.index = currentVC.index + 1
            }
        }
    }
}

extension UIStoryboard {
    static func vc() -> ViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
    }
}
