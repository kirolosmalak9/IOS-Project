//
//  LastestResultsView.swift
//  Sports
//
//  Created by Kirolos Malak on 3/6/21.
//

import UIKit
import Alamofire
import SwiftyJSON


class LastestResultsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    
    var lastestResults: Array<LastestResult> = []
    
    @IBOutlet weak var lastestResultsCollectionView: UICollectionView!
    
    var leagueId:String?{
        didSet{
            self.lastestResults = []
            let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=\(leagueId!)")
            
            
            
            request.validate().responseJSON { response in
                
                switch response.result {
                
                    case .success:
                        let result = try? JSON (data: response.data!)
                        
                        let lastestResults = result!["events"]
                        
                        for lastestResult in lastestResults.arrayValue {
                            
                            self.lastestResults.append(LastestResult(homeTeam: lastestResult["strHomeTeam"].string ?? "", secondTeam: lastestResult["strAwayTeam"].string ?? "", homeScore: lastestResult["intHomeScore"].string ?? "", secondScore: lastestResult["intAwayScore"].string ?? "", time: lastestResult["strTime"].string ?? "", date: lastestResult["dateEvent"].string ?? ""))

                        }
                        
                 
                      self.lastestResultsCollectionView.reloadData()
                        
                        

                case .failure(_):
                    print("error")
                }
                
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lastestResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  lastestResultsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let homeTeamLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let secondTeamLabel: UILabel = cell.viewWithTag(2) as! UILabel
        let homeScoreLabel: UILabel = cell.viewWithTag(3) as! UILabel
        let secondScoreLabel: UILabel = cell.viewWithTag(4) as! UILabel
        let timeEventLabel: UILabel = cell.viewWithTag(5) as! UILabel
        let dateEventLabel: UILabel = cell.viewWithTag(6) as! UILabel
        
        if lastestResults.count > indexPath.row && lastestResults.count > 0 {
            homeTeamLabel.text = lastestResults[indexPath.row].homeTeam
            secondTeamLabel.text = lastestResults[indexPath.row].secondTeam
            homeScoreLabel.text = lastestResults[indexPath.row].homeScore
            secondScoreLabel.text = lastestResults[indexPath.row].secondScore
            timeEventLabel.text = lastestResults[indexPath.row].time
            dateEventLabel.text = lastestResults[indexPath.row].date
        }
        
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        cell.backgroundColor = UIColor(red: 197/255, green: 98/255, blue: 0, alpha: 1)
        
        return cell
    }
    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        return CGSize(width: collectionView.frame.width - 16 , height: collectionView.frame.height)
    }
    
}
