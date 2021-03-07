//
//  LeaguesTableViewCell.swift
//  Sports
//
//  Created by Kirolos Malak on 3/3/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeaguesTableViewCell: UITableViewCell {
    
    
    var fetchLeague: FetchLeague?
    
    var index: Int?

    var leagueId: String?{
        didSet{
            if let id = leagueId {
                fetchLeague(idLeague: id)
            }
        }
    }
    
    var league: League?{
    didSet{
        if let league = league {
                        
            self.label.text =  league.strLeague
            
            self.uiImage.sd_setImage(with: URL(string: league.strBadge), placeholderImage: UIImage(named: "placeholder.png"))
            
            if league.strYoutube != "" {
                self.strYoutube =  URL(string: "http://" + league.strYoutube)
                self.buttonAction.isHidden = false
            }else {
                self.buttonAction.isHidden = true
            }
        }
    }
}
    
    var strYoutube: URL?

    @IBOutlet weak var uiImage: UIImageView!{
        didSet{
            
            uiImage.layer.masksToBounds = true
            uiImage.layer.cornerRadius = (150) / 2.0
            
            uiImage.layer.borderWidth = 4
            uiImage.layer.borderColor = UIColor.blue.cgColor
            uiImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var buttonAction: UIButton!
    @IBAction func buttonAction(_ sender: Any) {
        
        if let url = strYoutube {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fetchLeague(idLeague: String) {
        let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(idLeague)")
        
        
                    
        request.validate().responseJSON { response in
            
            
            switch response.result {
            
            case .success:
                let result = try? JSON (data: response.data!)
                
                let leagues = result!["leagues"]
                
                for leagueDetail in leagues.arrayValue {
                    
                    let strLeague = leagueDetail["strLeague"].string ?? ""
                    let strBadge = leagueDetail["strBadge"].string ?? ""
                    let strYoutube = leagueDetail["strYoutube"].string ?? ""

                    
                    self.fetchLeague?.fetchLeague(index: self.index!, strLeague: strLeague, strBadge: strBadge, strYoutube: strYoutube)

                    
                    self.label.text =  strLeague
                    
                    self.uiImage.sd_setImage(with: URL(string: strBadge), placeholderImage: UIImage(named: "placeholder.png"))
                    
                    
                    if strYoutube != "" {
                        self.strYoutube =  URL(string: "http://" + strYoutube )
                        self.buttonAction.isHidden = false
                    }else {
                        self.buttonAction.isHidden = true
                    }
                    
                    
                }

            case .failure(_):
                print("error")
            }
            
        }
        
    }
    
    static func nib() -> UINib{
            return UINib(nibName:"LeaguesTableViewCell", bundle: nil)
        }
    
}
