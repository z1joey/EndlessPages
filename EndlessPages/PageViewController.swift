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

        if index == NSNotFound {
            return nil
        }

        index += 1

        if index >= pages.count {
            index = 0
        }

        return pages[index]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        guard let current = viewController as? ViewController else { return nil }
        guard var index = pages.firstIndex(of: current) else { return nil }

        if index == NSNotFound {
            return nil
        }

        index -= 1

        if index < 0 {
            index = pages.count - 1
        }

        return pages[index]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.last as? ViewController else { return }
        guard let currentIndex = pages.firstIndex(of: currentVC) else { return }

        if completed {
            var lastIndex = currentIndex - 1
            var nextIndex = currentIndex + 1

            if lastIndex < 0 { lastIndex = pages.count - 1 }
            if nextIndex >= pages.count { nextIndex = 0 }

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
