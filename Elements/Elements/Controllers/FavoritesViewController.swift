//
//  FavoritesViewController.swift
//  Elements
//
//  Created by Manny Yusuf on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    
    private var favorites = [FavoriteElement]() {
        didSet {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchFavorites()
}
private func fetchFavorites() {
        guard let encodedName = Constants.Name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
        return
}
    ElementAPIClient.getFavoriteElement(name: encodedName) { (appError, favorites) in
        if let appError = appError {
            print(appError.errorMessage())
        } else if let favorites = favorites {
            self.favorites = favorites
            }
        }
    }
}
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        let favorite = favorites[indexPath.row]
        cell.textLabel?.text = "\(favorite.trackId)"
        cell.textLabel?.text = favorite.elementName
        cell.textLabel?.text = favorite.favoritedBy
        cell.textLabel?.text = favorite.elementSymbol
        return cell
    }
}

