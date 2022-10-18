//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    let arrayKey = "itemArray"
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: arrayKey) as? [String] {
            itemArray = items
        } else {
            defaults.set(itemArray, forKey: arrayKey)
        }
//        if defaults.array(forKey: arrayKey) == nil {
//            defaults.set(itemArray, forKey: arrayKey)
//        } else {
//            itemArray = defaults.array(forKey: arrayKey) as! [String]
//        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel!.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: self.arrayKey)
            self.tableView.reloadData()
            print("Success!")
        }
        alert.addTextField { alertTextField in
            textField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

