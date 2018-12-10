//
//  DeveloperViewController.swift
//  TeamProject
//
//  Created by David G Chopin on 11/6/18.
//  Copyright © 2018 David G Chopin. All rights reserved.
//

import UIKit

class DeveloperViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var gradientColors: [UIColor]!
    
    var ideas: [Idea] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        navigationItem.title = "Application Ideas"
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        self.tableView.register(IdeaCell.self, forCellReuseIdentifier: "cell")
        loadIdeasFromDatabase()
    }
    
    func loadIdeasFromDatabase() {
        let urlString = "http://arcadiatechnologies.net/ideas.php"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            for idea in jsonObject! {
                let name = idea["name"] as! String
                let description = idea["description"] as! String
                let id = idea["id"] as! String
                let claimed = Int((idea["claimed"] as! NSString).floatValue)
                let newIdea = Idea(name: name, description: description, id: id, claimed: claimed)
                if claimed == 0 {
                    self.ideas.append(newIdea)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}

extension DeveloperViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! IdeaCell
        cell.textLabel?.text = ideas[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let ideaVC = storyboard.instantiateViewController(withIdentifier: "IdeaViewController") as! IdeaViewController
        ideaVC.idea = ideas[indexPath.row]
        ideaVC.view.applyGradient(colours: gradientColors, cornerRadius: nil)
        self.navigationController?.pushViewController(ideaVC, animated: true)
    }
    
    
}
