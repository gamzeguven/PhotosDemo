//
//  ViewController.swift
//  PhotosDemo
//
//  Created by Gamze Güven on 20.04.2020.
//  Copyright © 2020 Gamze Güven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    var photosArray: [Result]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData()
        setTableView()
        self.title = "Photos"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTableView() {
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // MARK: - Get Data
    func getJsonData() {
        let accessToken = "jgZHuKUlhWskdfgW-WiPkwWy2tUC5AESVUaI"
        let url = URL(string: "https://gorest.co.in/public-api/photos?_format=json&access-token=\(accessToken)")
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error:\(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            guard let data = data else { return }
            let jsonDataItem = self.parseJSON(data: data)
            guard let jsonData = jsonDataItem else { return }
            guard let resultArray = jsonData.result else { return }
            DispatchQueue.main.async {
                self.photosArray = resultArray
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> Photos? {
        
        var returnValue: Photos?
        do {
            returnValue = try JSONDecoder().decode(Photos.self, from: data)
            
        } catch {
            print("Error:\(error)")
        }
        return returnValue
    }
}

// MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {fatalError("Unable cell")}
        
        cell.idLabel.text = "Albüm Numarası: \(photosArray?[indexPath.row].id ?? "")"
        cell.titleLabel.text = photosArray?[indexPath.row].title
        if let urlString = photosArray?[indexPath.row].thumbnail, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.resultImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
