//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Philippe Pringuet on 3/11/19.
//  Copyright © 2019 Philippe Pringuet. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultAnswerLbl: UILabel!
    @IBOutlet weak var resultDefinitionLbl: UILabel!
    
    var responses: [Answer]!
    
    func calculatePersonalityResult(){
        var responsesFrequency: [AnimalType:Int] = [:]
        
        let responseTypes = responses.map{$0.type}
        
        for response in responseTypes{
            responsesFrequency[response] = (responsesFrequency[response] ?? 0) + 1
        }
        let responsesFrequencySorted = responsesFrequency.sorted(by: {(pair1,pair2)-> Bool in return pair1.value > pair2.value})
        let mostCommonAnswer =  responsesFrequencySorted.first!.key
        
        resultAnswerLbl.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLbl.text = mostCommonAnswer.definition
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton=true
        

        // Do any additional setup after loading the view.
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
