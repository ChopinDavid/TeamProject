//
//  SubmitViewController.swift
//  TeamProject
//
//  Created by David G Chopin on 11/6/18.
//  Copyright © 2018 David G Chopin. All rights reserved.
//

import UIKit

class SubmitViewController: UIViewController {
    
    @IBOutlet var ideaNameTextField: UITextField!
    @IBOutlet var ideaDescriptionTextView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var textViewIsEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ideaNameTextField.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.5)
        ideaDescriptionTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.5)
        
        navigationItem.title = "Submit an Idea"
        
        setUpTextField()
        setUpTextView()
        activityIndicator.isHidden = true
        activityIndicator.layer.cornerRadius = activityIndicator.frame.width/2
    }
    
    func setUpTextField() {
        //Add Toolbar to textField
        let nameTextFieldToolBar = UIToolbar().ToolbarPicker(mySelect: #selector(dismissPicker))
        ideaNameTextField.inputAccessoryView = nameTextFieldToolBar
        ideaNameTextField.autocapitalizationType = .words
    }
    
    func setUpTextView() {
        //Placeholder set-up for ideaDescriptionTextView
        ideaDescriptionTextView.delegate = self
        ideaDescriptionTextView.text = "Idea description..."
        ideaDescriptionTextView.textColor = UIColor.officialApplePlaceholderGray
        
        ideaDescriptionTextView.selectedTextRange = ideaDescriptionTextView.textRange(from: ideaDescriptionTextView.beginningOfDocument, to: ideaDescriptionTextView.beginningOfDocument)
        
        //Round the textView and give it a border so that it looks like the above textField
        ideaDescriptionTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        ideaDescriptionTextView.layer.borderWidth = 0.5
        ideaDescriptionTextView.layer.cornerRadius = 5
        ideaDescriptionTextView.clipsToBounds = true
        
        //Add Toolbar to textView
        let descriptionTextViewToolBar = UIToolbar().ToolbarPicker(mySelect: #selector(dismissPicker))
        ideaDescriptionTextView.inputAccessoryView = descriptionTextViewToolBar
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    @objc func dismissPicker() {
        if textViewIsEditing {
            ideaDescriptionTextView.endEditing(true)
            textViewIsEditing = false
        }
        ideaNameTextField.endEditing(true)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        if ideaNameTextField.text != nil && ideaNameTextField.text != "" && ideaDescriptionTextView.text != nil && ideaDescriptionTextView.text != "Idea description..." {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            let currentUnixTime = Int(Date().timeIntervalSince1970.rounded())
            let randomString = self.randomString(length: 15)
            let id = "\(currentUnixTime)\(randomString)"
            let url = URL(string: "http://www.arcadiatechnologies.net/ideaPost.php?name=\(ideaNameTextField.text!)&description=\(ideaDescriptionTextView.text!)&id=\(id)&claimed=0)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
                
                DispatchQueue.main.async {
                    self.navigationController!.popToRootViewController(animated: true)
                }
            }
            task.resume()
        } else {
            let alert = UIAlertController(title: "Empty text field(s)", message: nil, preferredStyle: UIAlertController.Style.alert)
            if (ideaNameTextField.text == nil || ideaNameTextField.text == "") && (ideaDescriptionTextView.text == nil || ideaDescriptionTextView.text == "Idea description...") {
                //Both fields are empty
                alert.message = "Please fill out the \"Idea Name\" and \"Idea Description\" text fields to submit your idea."
            } else if ideaNameTextField.text == nil || ideaNameTextField.text == "" {
                //Idea name text field is empty
                alert.message = "Please fill out the \"Idea Name\" text field to submit your idea."
            } else {
                //Idea description text view is empty
                alert.message = "Please fill out the \"Idea Description\" text field to submit your idea."
                print(ideaNameTextField.text)
            }
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
}

extension SubmitViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the ideaDescriptionTextView text and the replacement text to
        // create the updated text string
        let currentText:String = ideaDescriptionTextView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            ideaDescriptionTextView.text = "Idea description..."
            ideaDescriptionTextView.textColor = UIColor.officialApplePlaceholderGray
            
            ideaDescriptionTextView.selectedTextRange = ideaDescriptionTextView.textRange(from: ideaDescriptionTextView.beginningOfDocument, to: ideaDescriptionTextView.beginningOfDocument)
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, set
            // the text color to black then set its text to the
            // replacement string
        else if ideaDescriptionTextView.textColor == UIColor.officialApplePlaceholderGray && !text.isEmpty {
            ideaDescriptionTextView.textColor = UIColor.black
            ideaDescriptionTextView.text = text
        }
            
            // For every other case, the text should change with the usual
            // behavior...
        else {
            return true
        }
        
        // ...otherwise return false since the updates have already
        // been made
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if ideaDescriptionTextView.textColor == UIColor.officialApplePlaceholderGray {
                ideaDescriptionTextView.selectedTextRange = ideaDescriptionTextView.textRange(from: ideaDescriptionTextView.beginningOfDocument, to: ideaDescriptionTextView.beginningOfDocument)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Idea description..." {
            textView.text = nil
        }
        textViewIsEditing = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewIsEditing = false
    }

}
