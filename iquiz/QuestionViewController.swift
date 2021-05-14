//
//  QuestionViewController.swift
//  iquiz
//
//  Created by Pragyna Naik on 5/11/21.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var answerChosen: Int = 0
    var question = [[String]]()
    var optionsQ = [[String]]()
    var correctA = [[Int]] ()
    var arrayQuestionSize = 0
    var questionTracker = 0
    var correctAnswerS = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        arrayQuestionSize = question.count
        let cell = tableView.dequeueReusableCell(withIdentifier: "Options", for: indexPath)
                
        cell.textLabel?.text = optionsQ[questionTracker][indexPath.row]
        

        
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        answerChosen = indexPath.row
        let index = correctA[questionTracker][0]
        correctAnswerS = optionsQ[questionTracker][index]
    }

    
    let answers = ["Answer-1", "Answer-2", "Answer-3", "Answer-4"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        questionLabel.text = question[questionTracker][0]
        
        // question[question.count - 1]
        
       // questionLabel.text = "Here is question"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
       
        performSegue(withIdentifier: "answer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "answer" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! AnswerViewController
                controller.question = questionLabel.text!
                controller.currentAnswer = answerChosen
                controller.correctAnswer = correctA[questionTracker][0]
                controller.correctAnswerString = correctAnswerS
    
                if (questionTracker != arrayQuestionSize) {
                    questionTracker = questionTracker + 1
                    controller.isFinished = false
                } else {
                    controller.isFinished = true
                }

            }
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
