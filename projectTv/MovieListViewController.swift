//
//  MovieListViewController.swift
//  projectTv
//
//  Created by William Doyle on 28/08/2018.
//  Copyright © 2018 William Doyle. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]?
    var page: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
    }
    
    func getMovies() {
        let base_url = "https://api.themoviedb.org/3/"
        let api_key = "&api_key=cf73a59652c9a9806c06af8a6295e3a3"
        
        guard let url = URL(string: "\(base_url)discover/movie?sort_by=popularity.desc\(api_key)") else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            guard let data = data else { return }
            do {
                if let responseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    print("movies: \(self.movies!)")
                    self.page = responseDictionary["page"] as? Int
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("JSON error")
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell") as? PosterCell else { return UITableViewCell() }
        
        let posterURL = "https://image.tmdb.org/t/p/w342"

        if let posterPath = URL(string: "\(posterURL)\(String(describing: self.movies![indexPath.row]["poster_path"] as? String))!") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: posterPath)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.PosterCell.image = image
                    }
                }
            }
        }
        return cell
    }
    
}
