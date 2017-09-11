//
//  SplashPageViewController.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

class SplashPageViewController: BaseController {

    let networkClient = NetworkClient.shared
    var products : [Product] = []

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.color = .gray
        fetchProducts()
    }
    
    func fetchProducts() {
        networkClient.loadProducts { [weak self] products, error  in
            guard error == nil else {
                self?.showErrorMessage(title: error?.localizedTitle, message: error?.localizedDescription)
                return
            }
            guard let products = products else { return }
            self?.products = products
            self?.performSegue(withIdentifier: "showProducts", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProducts" {
            if let controller = segue.destination as? UINavigationController,
               let productsVC = controller.viewControllers.first as? ProductsViewController {
                productsVC.viewModel = ProductsViewModel(products: products)
            }
        }
    }
}
