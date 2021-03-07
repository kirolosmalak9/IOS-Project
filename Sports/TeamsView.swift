//
//  TeamsView.swift
//  Sports
//
//  Created by Kirolos Malak on 3/6/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class TeamsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    var teams: Array<Team> = []
    var uiViewController: UIViewController?

    
    var leagueId:String?{
        didSet{
            self.teams = []
            let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=\(leagueId!)")
            
            
            
            request.validate().responseJSON { response in
                
                switch response.result {
                
                    case .success:
                        let result = try? JSON (data: response.data!)
                        
                        let teams = result!["teams"]
                        
                        for team in teams.arrayValue {
                            
                            
                            self.teams.append(Team(image: team["strTeamBadge"].string ?? "", teamName: team["strTeam"].string ?? "", sportName: team["strSport"].string ?? "", established: team["intFormedYear"].string ?? "", stadiumLoc: team["strStadiumLocation"].string ?? "", stadium: team["strStadium"].string ?? "", subNames: team["strAlternate"].string ?? ""))
                            

                        }
                        
                 
                      self.teamsCollectionView.reloadData()
                        
                        

                case .failure(_):
                    print("error")
                }
                
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  teamsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imageView: UIImageView = cell.viewWithTag(1) as! UIImageView

                
        if teams.count > indexPath.row && teams.count > 0 {
            imageView.sd_setImage(with: URL(string: teams[indexPath.row].image!), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var teamsDetailsViewController: TeamsDetailsViewController?
        
        teamsDetailsViewController = self.uiViewController!.storyboard!.instantiateViewController(withIdentifier: "teamsDetailsViewController") as? TeamsDetailsViewController

        teamsDetailsViewController?.team = self.teams[indexPath.row]

        self.uiViewController!.present(teamsDetailsViewController!, animated: true, completion: nil)
    }
    

}
