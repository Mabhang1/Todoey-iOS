//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//  Completed By Abhang Mane @Goldmedal

import UIKit
import Foundation

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath!)
        loadItems()

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary operator for the code below
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        
        saveItems()
        
        tableView.deselectRow(at: indexPath,animated:true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Textfield for entering new todo item
        var textField = UITextField()
        let alert = UIAlertController(title: "Create a new todoey item", message: "", preferredStyle: .alert)
        
        let newItem = Item()
        newItem.title = textField.text!
     
        //alert action with closure for printing text entered in textfield
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            self.itemArray.append(newItem)
            
            self.saveItems()
            self.tableView.reloadData()
        }
        
        //adding textfield into alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new todoey item"
            textField = alertTextField
        }
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        //using action on alert
        alert.addAction(addAction)
        present(alert,animated:true,completion:nil)
            
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }catch{
            print(error)
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self,from:data)
        }
            catch{
            print(error)
            }
            
        }
    }
}
