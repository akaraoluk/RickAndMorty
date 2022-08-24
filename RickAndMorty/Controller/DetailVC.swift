//
//  DetailVC.swift
//  RickAndMorty
//
//  Created by Abdurrahman Karaoluk on 10.05.2022.
//

import UIKit
import Alamofire
import Kingfisher

class DetailVC: UIViewController {
    
    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var detailName: UILabel!
    
    @IBOutlet var detailStatus: UILabel!
    
    @IBOutlet var detailSpecies: UILabel!
    
    @IBOutlet var detailType: UILabel!
    
    @IBOutlet var detailGender: UILabel!
    
    @IBOutlet var detailOriginName: UILabel!
    
    @IBOutlet var detailLocationName: UILabel!
    
    @IBOutlet var detailEpisodes: UILabel!
    
    var charModel: CharModel?
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            return decoder
        }()
        
        AF
            .request("https://rickandmortyapi.com/api/character/\(Int(id ?? 0))")
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success(let items):
                    
                    do {
                        let decoded = try decoder.decode(CharDecodeModel.self, from: response.data!)
                        
                        self.charModel = (CharModel(id: decoded.id, name: decoded.name, status: decoded.status, species: decoded.species, type: decoded.type, gender: decoded.gender, origin: decoded.origin.name, location: decoded.location.name, episode: decoded.episode[0], image: decoded.image))
                        
                        let episodeStr = decoded.episode.map { (str) -> String in
                            return String(str).components(separatedBy: "/").last!
                        }.joined(separator: ", ")
                        self.charModel?.episode = episodeStr
                        
                        self.setData()
                        
                    } catch {
                        print(String(describing: error))
                    }
                    
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
                
            }
    }
    
    func setData() {
        
        DispatchQueue.main.async{
            self.detailName.text = self.charModel?.name
            self.detailStatus.text = self.charModel?.status
            self.detailSpecies.text = self.charModel?.species
            self.detailType.text = self.charModel?.type
            self.detailGender.text = self.charModel?.gender
            self.detailOriginName.text = self.charModel?.origin
            self.detailLocationName.text = self.charModel?.location
            self.detailEpisodes.text = self.charModel?.episode
            
            let url = URL(string: (self.charModel?.image!)!)
            self.detailImageView.kf.setImage(with: url)
        }
        
    }
    
}
