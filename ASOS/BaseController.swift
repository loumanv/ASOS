//
//  UINavigationBar+Extensions.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 10/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationItems()
    }

    func addNavigationItems() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        let favouritesImage = UIImage(named: "wishlist")
        let shoppingBagImage = UIImage(named: "basket")
        let favouritesButton = UIBarButtonItem(image: favouritesImage, style: .plain, target: self, action: #selector(favouritesButtonPressed))
        let shoppingBagButton = UIBarButtonItem(image: shoppingBagImage, style: .plain, target: self, action: #selector(shoppingBagButtonPressed))
        favouritesButton.tintColor = .black
        shoppingBagButton.tintColor = .black

        navigationItem.rightBarButtonItems = [shoppingBagButton, favouritesButton]
    }

    func favouritesButtonPressed(sender: AnyObject) {
        showErrorMessage(title: "Favourites", message: Favourites.shared.itemsDescription().description)
    }

    func shoppingBagButtonPressed(sender: AnyObject) {
        showErrorMessage(title: "Shopping Bag", message: ShoppingBag.shared.itemsDescription().description)
    }

    func showErrorMessage(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
