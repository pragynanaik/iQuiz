//
//  FinishedViewController.swift
//  iquiz
//
//  Created by Pragyna Naik on 5/11/21.
//

import UIKit

class FinishedViewController: UIViewController {

    let answer = true
    let score = 0
    
    @IBOutlet weak var feedback: UILabel!
    
    @IBOutlet weak var quizScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (answer) {
            feedback.text = "Perfect!"
            quizScore.text = "0/1"
        } else {
            feedback.text = "Almost!"
            quizScore.text = "1/1"
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backMain(_ sender: Any) {
        performSegue(withIdentifier: "backMain", sender: self)
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
