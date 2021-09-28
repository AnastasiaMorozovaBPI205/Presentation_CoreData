//
//  ViewController.swift
//  Presentation_CoreData
//
//  Created by Anastasia on 28.09.2021.
//

import UIKit

import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
         
        let person = people[indexPath.row]
        cell.textLabel!.text = person.value(forKey: "name") as? String
         
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
     
        do {
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
            
            if let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject] {
              people = results
            }
            
        } catch {
            print(error)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func saveName(name: String) {
     
      let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      
        let entity =  NSEntityDescription.entity(
            forEntityName: "Person",
            in: managedContext
      )
     
      let person = NSManagedObject(
        entity: entity!,
        insertInto:managedContext
      )
     
      person.setValue(name, forKey: "name")
    
      people.append(person)
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
            self.saveName(name: textField.text!)
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
    
    var people = [NSManagedObject]()
    var name = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Names List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
      }

}

