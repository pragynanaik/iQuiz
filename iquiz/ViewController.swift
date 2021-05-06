//
//  ViewController.swift
//  iquiz
//
//  Created by Pragyna Naik on 5/5/21.
//

import UIKit

class SubjectView : NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = descriptions[indexPath.row]
        
        return cell
    }

    
    let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    let descriptions = ["All algebraic expressions and mathematical methods tested.", "The very best superheroes coming your way.", "Physics, Biology, Chemistry, and so much more!"]
}

class ViewController: UIViewController {
    let data = SubjectView()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = data
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func settingsPop(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    

}

