//
//  MasterViewController.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

}

class MasterViewController: UITableViewController, APIControllerProtocol {

    var detailViewController: DetailViewController? = nil
    var movies = [MovieModel]()
    var page: Int = 1
    
    lazy var api: Api = Api(delegate: self)
    func didReceiveAPIResults(results: NSDictionary?) {
        DispatchQueue.main.async {
            let jsonMovieArray: NSArray = results!["results"] as! NSArray
            for object in jsonMovieArray {
                let movie = MovieModel(json: object as! [String : Any])
                if movie != nil {
                    self.movies.append(movie!)
                }
            }
            self.tableView.reloadData()
        }
        
    }
    
    func didReceiveMovie(results: FullMovieModel) {
        
    }
    
    func didReceiveImageResults(results: Data?) {
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        api.getTopRatedMovies(page: page){
            (data, error) -> Void in
            //any additional processing, other REST calls, etc.
        }
        self.title = "Top Rated"
        
        // Do any additional setup after loading the view, typically from a nib.
       // self.navigationItem.leftBarButtonItem = self.editButtonItem

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let movie = movies[indexPath.row] 
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.title = movie.title
                controller.movieId = movie.id
                controller.movieDescription = movie.overview
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell

        let movie = movies[indexPath.row]
        cell.titleLabel?.text = movie.title
        cell.descriptionLabel?.text = movie.overview
        cell.descriptionLabel?.numberOfLines = 0
        cell.releaseDateLabel?.text = "Release Date: " + movie.release_date!
       // cell.genreLabel?.text = movie.genre
        api.downloadImage(url: movie.posterPath!) {
            (data, error) -> Void in
            DispatchQueue.main.async {
                if let updateCell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell?
                {
                    updateCell.movieImage?.image = UIImage(data: data!)
                }
            }
            
        }
    
        if(tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height)) {
            print("bottom")
            page = page + 1
            api.getTopRatedMovies(page: page) {
                (data, error) -> Void in
            }
        }
    
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

