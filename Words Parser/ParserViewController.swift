//
//  ViewController.swift
//  Words Parser
//
//  Created by Grygorii Tarashchuk on 03.08.2022.
//

import UIKit

class ParserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputTextField.delegate = self
        self.inputTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }


    @IBAction func doParse(_ sender: Any) {
        if let str = inputTextField.text {
            if str.count > 0 {
                self.parseString(str: str)
            }else{
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.07
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: self.inputTextField.center.x - 10, y: self.inputTextField.center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: self.inputTextField.center.x + 10, y: self.inputTextField.center.y))

                self.inputTextField.layer.add(animation, forKey: "position")
            }
        }else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.inputTextField.center.x - 10, y: self.inputTextField.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.inputTextField.center.x + 10, y: self.inputTextField.center.y))

            self.inputTextField.layer.add(animation, forKey: "position")
        }
    }
    
    func parseString(str:String){
        let wordGroups = English.words
        var wordSequence = ""
        for word in wordGroups {
            if (str.range(of: word) != nil){
                if wordSequence.count > 0{
                    wordSequence += " "
                }
                wordSequence += word
            }
        }
        if wordSequence.count > 0 {
            showResult(resultString: wordSequence)
        }else {
            self.showNoResult()
        }
    }
    
    func showResult(resultString:String) {
        self.resultLabel.text = resultString
        UIView.animate(withDuration: 0.5) {
            self.resultLabel.alpha = 1.0
            self.resultTitleLabel.alpha = 1.0
        } completion: { Bool in
            
        }

    }
    
    func showNoResult() {
        self.resultLabel.text = "No match. Try other string"
        UIView.animate(withDuration: 0.5) {
            self.resultLabel.alpha = 1.0
            self.resultTitleLabel.alpha = 1.0
        } completion: { Bool in
            
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.resultLabel.text = ""
        UIView.animate(withDuration: 0.5) {
            self.resultLabel.alpha = 0.0
            self.resultTitleLabel.alpha = 0.0
        } completion: { Bool in
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.doParse(self)
        return true
    }
        
}

