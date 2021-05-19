import Cocoa

var str = "Hello, playground"

let url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
let task = URLSession.shared.dataTask(with: url!) { data, response, error in
    do {
        let questions = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
     //   let questions = try JSONSerialization.jsonObject(with: data!, options:  []) as? [String: Any]
        let first = (questions as! [Dictionary<String, Any>])[0]
        print(first["desc"] as! String)
        let questionDict = (first["questions"] as! [Dictionary<String, Any>])[0]
        let answers = questionDict["answers"] as! Array<String>
        print(answers[0])
        
    }
    catch {
        print("Error")
    }
}

task.resume()

