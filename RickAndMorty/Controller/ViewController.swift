//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Abdurrahman Karaoluk on 10.05.2022.
//

import UIKit
import Alamofire
import Kingfisher




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    
    var charModel: [CharDecodeModel]?
    var detailId: Int?
    
    var items: [CharModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            return decoder
        }()
        
        AF
            .request("https://rickandmortyapi.com/api/character")
            .validate(statusCode: 200..<300)
            .response { response in
                print(response.data)
                switch response.result {
                case .success(let items):
                    print("items", items)
                    do {
                        let decoded = try decoder.decode(RootModel.self, from: response.data!)
                        
                        for x in decoded.results {
                            self.items.append(CharModel(id: x.id, name: x.name, status: x.status, species: x.species, type: x.type, gender: x.gender, origin: x.origin.name, location: x.location.name, episode: x.episode[0], image: x.image))
                        }
                        print(self.items)
                        self.tableView.reloadData()
                        print(decoded.info.count)
                    } catch {
                        print(String(describing: error)) // <- ✅ Use this for debuging!
                    }
                
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            self.items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellRe", for: indexPath) as! CharCell
        cell.nameLabel.text = "Name:" + (self.items[indexPath.row].name!)
        cell.statusLabel.text = self.items[indexPath.row].status
        cell.speciesLabel.text = self.items[indexPath.row].species
                
        let url = URL(string: self.items[indexPath.row].image!)
        cell.charImageView.kf.setImage(with: url)
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 5
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        let borderColor: UIColor = (cell.statusLabel.text == "Alive") ? .green : .red
        cell.layer.borderColor = borderColor.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
            detailId = self.items[indexPath.row].id
            performSegue(withIdentifier: "toDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let destinationVC = segue.destination as! DetailVC
            destinationVC.id = detailId
        }
    }
    
}
