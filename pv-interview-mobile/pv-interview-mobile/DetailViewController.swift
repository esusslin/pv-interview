//
//  DetailViewController.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, APIControllerProtocol {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!

    @IBOutlet weak var generaLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    lazy var api: Api = Api(delegate: self)
    
    func didReceiveAPIResults(results: NSDictionary?) {
        
    }
    
    func didReceiveMovie(results: FullMovieModel) {
        DispatchQueue.main.async {
            let movie = results
            self.descriptionLabel.text = movie.overview
            self.releaseLabel.text = "Release Date: " + movie.release_date!
            self.companyLabel.text = movie.production
            
            self.api.downloadLargeImage(url: movie.backdropPath!) {
                (data, error) -> Void in
                    self.movieImageView.image = UIImage(data: data!)
            }
        }
    }
    
    func didReceiveImageResults(results: Data?) {
        
    }

    func configureView() {
        if let id = self.movieId {
            print(id)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getMovie(movieId: movieId!) {
            (data, error) -> Void in

        }
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

  
    
    var movieDescription: String? {
        didSet {
            self.configureView()
        }
    }
//
//    var movieTitle: String? {
//        didSet {
//            self.configureView()
//        }
//    }
    
    var movieId: Int? {
        didSet {
            self.configureView()
        }
    }
    
    var productionCompany: String? {
        didSet {
            self.configureView()
        }
    }
    
    
    var detailItem: String?
}

