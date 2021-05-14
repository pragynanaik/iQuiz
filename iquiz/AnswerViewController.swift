//
//  AnswerViewController.swift
//  iquiz
//
//  Created by Pragyna Naik on 5/11/21.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var question = "Question For Now"
    var correctAnswer = 0
    var correctAnswerString = ""
    var isCorrect = false
    var currentAnswer = 0
    var isFinished = false 

    @IBOutlet weak var isCorrectLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var correctLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = question
        if (currentAnswer == correctAnswer) {
            isCorrect = true
            isCorrectLabel.text = "Yay you did it!"
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
