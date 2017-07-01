//
//  DetailViewController.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!

    @IBOutlet weak var generaLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    
    func configureView() {
        if let description = self.movieDescription {
            if let label = self.descriptionLabel {
                //print(description)
                label.text = description
            }
        }
        
        if let title = self.movieTitle {
            print(title)
            self.title = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    
    var movieDescription: String? {
        didSet {
            self.configureView()
        }
    }

    var movieTitle: String? {
        didSet {
            self.configureView()
        }
    }
    
    var movieId: Int? {
        didSet {
            self.configureView()
        }
    }
    
    var detailItem: String?
}

