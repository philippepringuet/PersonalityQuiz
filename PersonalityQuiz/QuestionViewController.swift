//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Philippe Pringuet on 3/11/19.
//  Copyright © 2019 Philippe Pringuet. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var questionsIndex = 0
    
    @IBOutlet weak var singleStackVIew: UIStackView!
    @IBOutlet weak var multipleStackVIew: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    
    
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var singleBtn1: UIButton!
    @IBOutlet weak var singleBtn2: UIButton!
    @IBOutlet weak var singleBtn3: UIButton!
    @IBOutlet weak var singleBtn4: UIButton!
    
    @IBOutlet weak var multipleLbl1: UILabel!
    @IBOutlet weak var multipleLbl2: UILabel!
    @IBOutlet weak var multipleLbl3: UILabel!
    @IBOutlet weak var multipleLbl4: UILabel!
    
    @IBOutlet weak var rangedLbl1: UILabel!
    @IBOutlet weak var rangedLbl2: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type:.single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
            ]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
            ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous",
                           type: .rabbit),
                    Answer(text: "I barely notice them",
                           type: .turtle),
                    Answer(text: "I love them", type: .dog)
            ])
    ]
    
    var answersChosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        rangedStackView.isHidden=true
        singleStackVIew.isHidden=true
        multipleStackVIew.isHidden=true
        
        let currentQuestion = questions[questionsIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionsIndex)/Float(questions.count)
        
        self.navigationItem.title="Question #\(questionsIndex+1)"
        questionLbl.text = currentQuestion.text
        progressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type{
        case .single:
            singleStackVIew.isHidden=false
            singleBtn1.setTitle(currentAnswers[0].text, for: .normal)
            singleBtn2.setTitle(currentAnswers[1].text, for: .normal)
            singleBtn3.setTitle(currentAnswers[2].text, for: .normal)
            singleBtn4.setTitle(currentAnswers[3].text, for: .normal)
            
        case .multiple:
            multipleStackVIew.isHidden=false
            multiSwitch1.isOn=false
            multiSwitch2.isOn=false
            multiSwitch3.isOn=false
            multiSwitch4.isOn=false
            multipleLbl1.text = currentAnswers[0].text
            multipleLbl2.text = currentAnswers[1].text
            multipleLbl3.text = currentAnswers[2].text
            multipleLbl4.text = currentAnswers[3].text
            
        case .ranged:
            rangedStackView.isHidden=false
            rangedSlider.setValue(0.5, animated: false)
            rangedLbl1.text = currentAnswers.first?.text
            rangedLbl2.text = currentAnswers.last?.text
        }
        
    }
    
  
    @IBAction func singleAnswerBtnPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionsIndex].answers
        switch sender{
        case singleBtn1:
            answersChosen.append(currentAnswers[0])
        case singleBtn2:
            answersChosen.append(currentAnswers[1])
        case singleBtn3:
            answersChosen.append(currentAnswers[2])
        case singleBtn4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleAnswerBtnPressed() {
        let currentAnswers = questions[questionsIndex].answers
        if multiSwitch1.isOn{
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn{
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn{
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn{
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerBtnPressed() {
        
        let currentAnswers = questions[questionsIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion(){
        questionsIndex+=1
        if questionsIndex<questions.count{
            updateUI()
        }else{
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue"{
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
        
    }
}
