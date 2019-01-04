//
//  ElementDetailedViewController.swift
//  Elements
//
//  Created by Manny Yusuf on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailedViewController: UIViewController {
    
public var elementsTwo: Element!
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltLabel: UILabel!
    @IBOutlet weak var boilLabel: UILabel!
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = elementsTwo.name
         updateUI()

    }
    private func updateUI() {
        if let image = ImageHelper.shared.image(forKey: "http://images-of-elements.com/\(elementsTwo.name.lowercased()).jpg" as NSString) {
            elementImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(elementsTwo.name.lowercased()).jpg") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementImage.image = image
                }
            }
        }
        symbolLabel.text = elementsTwo.symbol
        numberLabel.text = "\(elementsTwo.number)"
        weightLabel.text = "\(elementsTwo.atomic_mass)"
        meltLabel.text = "\(elementsTwo.melt ?? 0.0)"
        boilLabel.text = "\(elementsTwo.boil ?? 0.0)"
        discoverLabel.text = elementsTwo.discovered_by
        
        
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        let favorite = FavoriteElement.init(trackId: elementsTwo.number, elementName: elementsTwo.name, favoritedBy: "Manny", elementSymbol: elementsTwo.symbol)
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementAPIClient.favoriteElement(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "successfully favorited podcast", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "was not favorited", message: "")
                    }
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
}

