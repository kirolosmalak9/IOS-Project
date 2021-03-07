//
//  UpComingEventsView.swift
//  Sports
//
//  Created by Kirolos Malak on 3/6/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class UpComingEventsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    var events: Array<Event> = []
    
    @IBOutlet weak var upComingEventsCollectionView: UICollectionView!
    
    var leagueId:String?{
        didSet{
            self.events = []
            let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=\(leagueId!)")
            
            
            
            request.validate().responseJSON { response in
                
                switch response.result {
                
                    case .success:
                        let result = try? JSON (data: response.data!)
                        
                        let events = result!["events"]
                        
                        for event in events.arrayValue {
                            
                            self.events.append(Event(name: event["strEvent"].string ?? "", time: event["strTime"].string ?? "", date: event["dateEvent"].string ?? ""))
                        }
                        
                 
                      self.upComingEventsCollectionView.reloadData()
                        
                        

                case .failure(_):
                    print("error")
                }
                
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  upComingEventsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let nameEventLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let timeEventLabel: UILabel = cell.viewWithTag(2) as! UILabel
        let dateEventLabel: UILabel = cell.viewWithTag(3) as! UILabel
        
        if events.count > indexPath.row && events.count > 0 {
            nameEventLabel.text = events[indexPath.row].name
            timeEventLabel.text = events[indexPath.row].time
            dateEventLabel.text = events[indexPath.row].date
        }
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        cell.backgroundColor = UIColor(red: 197/255, green: 98/255, blue: 0, alpha: 1)
        
        cell.backgroundColor = UIColor(red: 1, green: 194/255, blue: 70/255, alpha: 1)
        
        return cell
    }
    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        return CGSize(width: collectionView.frame.width * 0.75 , height: collectionView.frame.height - 16)
    }
    

}
