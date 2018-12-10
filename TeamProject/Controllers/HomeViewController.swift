//
//  ViewController.swift
//  TeamProject
//
//  Created by David G Chopin on 11/6/18.
//  Copyright © 2018 David G Chopin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var submissionButton: UIButton!
    @IBOutlet var developerButton: UIButton!
    var submissionButtonGradientColors: [UIColor]!
    var developerButtonGradientColors: [UIColor]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add gradients to buttons
        submissionButtonGradientColors = [UIColor(red: 105/255, green: 180/255, blue: 2/255, alpha: 1), UIColor(red: 40/255, green: 156/255, blue: 118/255, alpha: 1)]
        submissionButton.applyGradient(colours: submissionButtonGradientColors, cornerRadius: 15)
        developerButtonGradientColors  = [UIColor(red: 139/255, green: 1/255, blue: 70/255, alpha: 1), UIColor(red: 144/255, green: 37/255, blue: 140/255, alpha: 1)]
        developerButton.applyGradient(colours: developerButtonGradientColors, cornerRadius: 15)
        
        //Round the button corners
        roundButtonCorners()
    }
    
    func roundButtonCorners() {
        submissionButton.layer.cornerRadius = 15
        developerButton.layer.cornerRadius = 15
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SubmitViewController") as! SubmitViewController
        vc.view.applyGradient(colours: submissionButtonGradientColors, cornerRadius: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func developerButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DeveloperViewController") as! DeveloperViewController
        vc.view.applyGradient(colours: developerButtonGradientColors, cornerRadius: nil)
        vc.gradientColors = developerButtonGradientColors
        navigationController?.pushViewController(vc, animated: true)
    }
}

