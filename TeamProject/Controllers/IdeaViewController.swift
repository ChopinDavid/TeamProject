//
//  IdeaViewController.swift
//  TeamProject
//
//  Created by David G Chopin on 12/10/18.
//  Copyright © 2018 David G Chopin. All rights reserved.
//

import UIKit

class IdeaViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    var idea: Idea!
    var textViewIsEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateVC()
    }
    
    func populateVC() {
        nameLabel.text = idea.name
        descriptionTextView.text = idea.description
        setUpTextView()
    }
    
    func setUpTextView() {
        //Round the textView and give it a border so that it looks like the above textField
        descriptionTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.clipsToBounds = true
        descriptionTextView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
    }
    
    @IBAction func claimButtonPressed(_sender: Any) {
        let alert = UIAlertController(title: "Claim?", message: "Do you want to claim this idea?", preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let claim = UIAlertAction(title: "Claim", style: .default) { (action) in
            self.claimIdea()
        }
        alert.addAction(claim)
        self.present(alert, animated: true, completion: nil)
    }
    
    func claimIdea() {
        let url = URL(string: "http://www.arcadiatechnologies.net/claimIdea.php?id=\(idea.id!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
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
            let alert = UIAlertController(title: "Claimed!", message: "Now this idea is all yours.", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: {
                if let developerVC = self.navigationController!.viewControllers[1] as? DeveloperViewController {
                    developerVC.ideas = []
                    developerVC.loadIdeasFromDatabase()
                    developerVC.tableView.reloadData()
                }
            })
        }
        task.resume()
    }
    
}
