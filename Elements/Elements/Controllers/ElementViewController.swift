//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {

    @IBOutlet weak var elementTableView: UITableView!
    
    private var atomicElements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.elementTableView.reloadData()
            }
        }
    }
override func viewDidLoad() {
    super.viewDidLoad()
    searchElement(keyword: "swift")
    elementTableView.dataSource = self
    elementTableView.delegate = self
}
    private func searchElement(keyword: String) {
        ElementAPIClient.searchElement(keyword: keyword) { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
                self.atomicElements = elements
            }
        }
    }
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = elementTableView.indexPathForSelectedRow,
        let detailViewController = segue.destination as? ElementDetailedViewController else {
            fatalError("indexPath, detailVC nil")
}
        let elements = atomicElements[indexPath.row]
        detailViewController.elementsTwo = elements
    }
}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return atomicElements.count
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = elementTableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementCell else {
            fatalError("ElementCell error")
    }
        let elements = atomicElements[indexPath.row] 
        cell.configureCell(element: elements)
        return cell
    }
}

extension ElementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
