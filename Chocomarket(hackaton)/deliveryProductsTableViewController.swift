//
//  deliveryProductsTableViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 03.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class deliveryProductsTableViewController: UITableViewController {

    
    
    var id = ""
    var index:Int = 5
    var products: Dictionary<String, [String]>?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func takeButtonTapped(_ sender: Any) {
        
        print(id, "pihaem v eto idishku", index, "s indexom")
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()

        db.collection("users").getDocuments { (snapshot, error) in
            let document = snapshot?.documents
            for i in 0...((snapshot?.documents.count)!-1){
                if(document![i].data()["uid"] as! String == userId!){
                    db.collection("Deliveries").document(self.id).updateData(["delivererId" : userId!,
                    "delivererName": document![i].data()["name"] as! String,
                    "inProcess": "inProcess"
                    ])
                    
                    break
                }
            }
        }
        let alert = UIAlertController(title: "Status", message: "You had taken delivery", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (products?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryProducts", for: indexPath)
        let intIndex = indexPath.row // where intIndex < myDictionary.count
        let index = products!.index(products!.startIndex, offsetBy: intIndex)

        cell.textLabel?.text = products!.keys[index]
        cell.detailTextLabel?.text = products![products!.keys[index]]![0]
        return cell
    }
////

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
