//
//  AnswerViewController.swift
//  iquiz
//
//  Created by Pragyna Naik on 5/11/21.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var question = "Question For Now"
    var correctAnswer = 99999
    var correctAnswerString = ""
    var isCorrect = false
    var currentAnswer = 0
    var isFinished = true
    
    var questions_Answer = [[String]]()
    var options_Answer = [[String]]()
    var answer_Answer = [[Int]]()
    var tracker = 0
    var correctAnswerNum = 0
    var totalQuestion = 0

    @IBOutlet weak var isCorrectLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var correctLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = question
        
        print("Now check this")
        print(currentAnswer)
        print(correctAnswer)
        print("This is it")
        if (currentAnswer == correctAnswer) {
            isCorrect = true
            isCorrectLabel.text = "Yay you did it!"
            correctAnswerNum = correctAnswerNum + 1
        } else {
            isCorrectLabel.text = "You are wrong dummy!"
        }
        
        correctLabel.text = correctAnswerString
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toFinished(_ sender: Any) {
        if (isFinished) {
            performSegue(withIdentifier: "finished", sender: self)

            
        } else {
            performSegue(withIdentifier: "moreQuestion", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "moreQuestion" {

                let controller = segue.destination as! QuestionViewController
                controller.correctA = answer_Answer
                controller.optionsQ = options_Answer
                controller.question = questions_Answer
                controller.questionTracker = tracker
                controller.correctNum = correctAnswerNum
            
        } else {
            let controller = segue.destination as! FinishedViewController
            
            controller.score = correctAnswerNum
            controller.totalQuestion = totalQuestion
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
