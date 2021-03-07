//
//  FavoriteLeaguesTableViewController.swift
//  Sports
//
//  Created by Kirolos Malak on 3/7/21.
//

import UIKit
import CoreData

class FavoriteLeaguesTableViewController: UITableViewController {

    var leagues: Array<League> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LeaguesTableViewCell.nib(), forCellReuseIdentifier: "leagueCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        leagues = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntity")
        
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                
                self.leagues.append(League(idLeague: data.value(forKey: "idLeague") as! String, strLeague: data.value(forKey: "strLeague") as! String, strSport: data.value(forKey: "strSport") as! String, strLeagueAlternate: data.value(forKey: "strLeagueAlternate") as! String, strYoutube: data.value(forKey: "strYoutube") as! String, strBadge: data.value(forKey: "strBadge") as! String))
            }
            
            tableView.reloadData()
        } catch {
            print("error context.fetch()")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let leaguesTableViewCell: LeaguesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell
        
        leaguesTableViewCell.league = leagues[indexPath.row]

        return leaguesTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntity")
            request.predicate = NSPredicate(format: "idLeague == %@", leagues[indexPath.row].idLeague! as NSString)
            
            do {
                let result = try context.fetch(request)
                for data in result {
                    context.delete(data as! NSManagedObject)
                }
                try context.save()
                leagues.remove(at: indexPath.row)
                tableView.reloadData()
            } catch {
                print("error context.fetch()")
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        

        if NetworkMontior.shared.isConnected {
            var leaguesDetailsViewController: LeaguesDetailsViewController?
            
            leaguesDetailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "leaguesDetailsViewController") as? LeaguesDetailsViewController
            
            leaguesDetailsViewController?.league = self.leagues[indexPath.row]
            self.present(leaguesDetailsViewController!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Connection", message: "No Network Connection.", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
