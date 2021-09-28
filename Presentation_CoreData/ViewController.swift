//
//  ViewController.swift
//  Presentation_CoreData
//
//  Created by Anastasia on 28.09.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
           cell.textLabel!.text = names[indexPath.row]
        
         return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    

    @IBAction func addName(_ sender: Any) {
        let alert = UIAlertController(
            title: "New name",
            message: "Add a new name",
            preferredStyle: .alert
        )
         
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            (action: UIAlertAction!) -> Void in
         
            let textField = alert.textFields![0]
            self.names.append(textField.text!)
            self.tableView.reloadData()
        }
         
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (action: UIAlertAction!) -> Void in
        }
         
        alert.addTextField {(textField: UITextField!) -> Void in }
         
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
         
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Names List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
      }

}

