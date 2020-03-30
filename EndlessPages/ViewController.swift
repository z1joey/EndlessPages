//
//  ViewController.swift
//  EndlessPages
//
//  Created by joey on 3/27/20.
//  Copyright © 2020 TGI Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    var index: Int = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = "\(index)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.text = "\(index)"
    }
}

