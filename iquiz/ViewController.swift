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
//    let descriptions = ["All algebraic expressions and mathematical methods tested.", "The very best superheroes coming your way.", "Physics, Biology, Chemistry, and so much more!"]

//    let questions = [[["What is .99.. repeating?"], ["What is 2 + 2"]],[["What is the real name of Black Widow"]] , [["What color is blood in your veins?"]]]
//
//    let options = [[["0", "1", "Infinity", "999"], ["0", "1", "4", "3"]], [["Stinky", "Star Wars", "Scarlett", "Potato"]], [["Blue", "Green", "Red", "Clear"]]]
//
//    let answers = [[[1],[2]],[[2]], [[2]]]
    
    
    var subjects = [String]()
    var descriptions = [String]()
    
    var questions: [[[String]]] = []
    var options: [[[String]]] = []
    var answers: [[[Int]]] = []
    
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
        
//        let chosenOptions = options[indexPath.row]
        
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
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        
        
        DispatchQueue.global().async {
            print("In this one")

            let url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                do {
                    let questions = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self.first = (questions as! [Dictionary<String, Any>])
                    let numberQuiz = self.first.count

                    for i in 0...(numberQuiz - 1) {
                        let first2 = self.first[i]
                        self.subjects.append(first2["title"] as! String)
                        self.descriptions.append(first2["desc"] as! String)
                        var tempArray = [[String]]()

                        var finalAnswer = [[String]]()


                        let questionDict = (first2["questions"] as! [Dictionary<String, Any>])

                        for questionChoice in questionDict{
                              let text = questionChoice["text"]!

                              var temporary:[String] = []

                              temporary.append(text as! String)
                             // if(questionTitle)
                              tempArray.append(temporary)

                        }
                        self.questions.append(tempArray)
                        
                        
                        var answersInput: [[String]] = []
                        
                        for choices in questionDict{
                            let text = choices["answers"]!
                            answersInput.append(text as! [String])
                        }
                        
                        
                        self.options.append(answersInput)
                        
                        
                        var result: [[Int]] = []
                        for answer in questionDict{
                        
                            var answersArray: [Int] = []

                            var answerText = answer["answer"]!
                            answerText = Int(answerText as! String)!
                            answerText = answerText as! Int - 1
 
                            answersArray.append(answerText as! Int)
                            
                            result.append(answersArray)

                        }
                        self.answers.append(result)
                        

                    }

              
                }
                catch {
                    print("Error")
                }
            }

            task.resume()

            Thread.sleep(forTimeInterval: 0.5)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }



        }
        
    }
    
    @IBAction func settingsPop(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "Add Custom URL"
        }

        alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: { (action) in
            let textField = alert.textFields![0]
            let urlInput = textField.text!
            var hasNetwork = false
//            DispatchQueue.main.async {
//                hasNetwork = self.checkNetwork(text: textField.text)
//            }
            
            if (hasNetwork) {
                print("Works")
            } else {
                print("doesnt'")
            }
        }))
      
        self.present(alert,animated: true)

    }


    func checkNetwork(text: String?) -> Bool  {
        let url = NSURL(string: text!)
        let request = NSMutableURLRequest(url: url! as URL)
        var statusCode = 0
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let response = response else {
//              print("Cannot found the response")
              return
            }
            let myResponse = response as! HTTPURLResponse
            print("Status Code:", myResponse.statusCode)
            statusCode = myResponse.statusCode
            print(statusCode)
            


        }
        
        task.resume()
        
        print("outside task")
        print(statusCode)
        return (statusCode == 200)
        
     }
        
}

