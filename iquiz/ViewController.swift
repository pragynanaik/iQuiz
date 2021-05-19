//
//  ViewController.swift
//  iquiz
//
//  Created by Pragyna Naik on 5/5/21.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var number: Int = 0
    var first: [Dictionary<String, Any>] = []
//
//    var subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    let descriptions = ["All algebraic expressions and mathematical methods tested.", "The very best superheroes coming your way.", "Physics, Biology, Chemistry, and so much more!"]

    let questions = [[["What is .99.. repeating?"], ["What is 2 + 2"]],[["What is the real name of Black Widow"]] , [["What color is blood in your veins?"]]]

    let options = [[["0", "1", "Infinity", "999"], ["0", "1", "4", "3"]], [["Stinky", "Star Wars", "Scarlett", "Potato"]], [["Blue", "Green", "Red", "Clear"]]]

    let answers = [[[1],[2]],[[2]], [[2]]]
    
    
    var subjects = ["", "", ""]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        //print("here")
        cell.textLabel?.text = self.subjects[indexPath.row]
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
      
        
        DispatchQueue.global().async {
            print("In this one")

            let url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                do {
                    let questions = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self.first = (questions as! [Dictionary<String, Any>])
                    
                    for i in 0...2 {
                        let first2 = self.first[i]
                        self.subjects[i] = (first2["title"] as! String)
                    }
                    print(self.subjects)
                    
                    //let questionDict = (first["questions"] as! [Dictionary<String, Any>])
    //                print(questionDict)
    //                let answers = questionDict["answers"] as! Array<String>
                    
    //                print(answers)
                }
                catch {
                    print("Error")
                }
            }

            task.resume()
            
            
            Thread.sleep(forTimeInterval: 10)
            
            DispatchQueue.main.async {
               
                print("I'm here")
                print(self.subjects)
            }
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        
        print("something")
        print(self.subjects)
    }
    
    @IBAction func settingsPop(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: nil))

        alert.addTextField { (textField) in
            textField.text = "Add Custom URL"
        }
        
        let textField = alert.textFields![0]
        

        self.present(alert,animated: true)

    }


    
}

