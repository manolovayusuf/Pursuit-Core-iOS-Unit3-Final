//
//  ElementCell.swift
//  Elements
//
//  Created by Manny Yusuf on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementName: UILabel!
    @IBOutlet weak var elementWeight: UILabel!
    
    var emptyString = ""
    public func configureCell(element: Element) {
        if element.number < 10 {
            emptyString = "00\(element.number)"
        } else {
            if element.number >= 10 && element.number < 100 {
                emptyString = "0\(element.number)"
            }
        }
        elementName.text = element.name
        elementWeight.text = "\(element.atomic_mass)"
        if let image = ImageHelper.shared.image(forKey: "http:www.theodoregray.com/periodictable/Tiles/\(emptyString)/s7.JPG" as NSString) {
            elementImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: "http:www.theodoregray.com/periodictable/Tiles/\(emptyString)/s7.JPG") { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.elementImage.image = image
                }
            }
        }
    }
}

