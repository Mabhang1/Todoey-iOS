//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//  Completed By Abhang Mane @Goldmedal

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Make Lunch","Make report","Complete Project"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //check if item pressed add checkmark else remove/none checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)!.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)!.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath,animated:true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Textfield for entering new todo item
        var textField = UITextField()
        let alert = UIAlertController(title: "Create A New Todo Item", message: "", preferredStyle: .alert)
        
        //alert action with closure for printing text entered in textfield
        let action = UIAlertAction(title: "Add An Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        //adding textfield into alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create A New Todo Item"
            textField = alertTextField
        }
        
        //using action on alert
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
            
    }
    
}

