//
//  ViewController.swift
//  iquiz
//
//  Created by Pragyna Naik on 5/5/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var number: Int = 0

    let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    let descriptions = ["All algebraic expressions and mathematical methods tested.", "The very best superheroes coming your way.", "Physics, Biology, Chemistry, and so much more!"]
    
    let questions = [[["What is .99.. repeating?"], ["What is 2 + 2"]],[["What is the real name of Black Widow"]] , [["What color is blood in your veins?"]]]
    
    let options = [[["0", "1", "Infinity", "999"], ["0", "1", "4", "3"]], [["Stinky", "Star Wars", "Scarlett", "Potato"]], [["Blue", "Green", "Red", "Clear"]]]
    
    let answers = [[[1],[2]],[[2]], [[2]]]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = descriptions[indexPath.row]
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let chosenTopic = questions[indexPath.row]
        
        let chosenOptions = options[indexPath.row]
        
        number = indexPath.row
        performSegue(withIdentifier: "question", sender: cell)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(questions[number])
        if segue.identifier == "question" {
                let controller = segue.destination as! QuestionViewController
                controller.question = questions[number]
                controller.optionsQ = options[number]
                controller.correctA = answers[number]
            
        } 
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func settingsPop(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }


    
}

