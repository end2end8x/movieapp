//
//  MasterViewController.swift
//  MovieApp
//
//  Created by Aloha Cool on 24/3/19.
//  Copyright © 2019 Aloha Cool. All rights reserved.
//

import UIKit

import MovieDynamicLibrary

class MasterViewController: UIViewController {

    var objects = [Any]()

    let path_movie = "/3/search/movie?query=a&"
    
    @IBOutlet weak var txtApiKey: UITextField!
    
    @IBOutlet weak var table: UITableView!
    
    var listMovie : [MovieSort] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addApiKey(_ sender: Any) {
        let baseApi = BaseApi.init()
        if let apiKey = txtApiKey.text {
            if !apiKey.isEmpty {
                baseApi.setApiKey(apiKey)
                baseApi.getJsonDataAsync(path_movie, withCallback: {(data : Data!, response : URLResponse!, error : Error!) in
                    if error == nil {
                        if let jsonString = String.init(bytes: data, encoding: String.Encoding.utf8) {
                            self.listMovie = baseApi.listMovieSorted(jsonString) as! [MovieSort]
//                            let _ : MovieList = baseApi.listMovieStruct(jsonString)
                            print(self.listMovie.count)
                            DispatchQueue.main.async {
                                self.table.reloadData()
                            }
                        }
                    }
                })
                txtApiKey.text = ""
            }
        }
    }
}

extension MasterViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.listMovie[indexPath.row]
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellIdentifier")
        }
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "rate: \(movie.vote_count)"
        return cell
    }
}
