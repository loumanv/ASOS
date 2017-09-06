//
//  SplashPageViewController.swift
//  ASOS
//
//  Created by Billybatigol on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

class SplashPageViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.color = .gray
    }
}
