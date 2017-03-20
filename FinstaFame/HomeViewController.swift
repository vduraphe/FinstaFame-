//
//  HomeViewController.swift
//  FinstaFame
//
//  Created by Vaidehi Duraphe on 3/8/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var postObjects: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        //20 images
        let query = PFQuery(className: "UserPost")
        query.limit = 20
        
        query.findObjectsInBackground { (response: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.postObjects = response
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //set table view to lots of cells!
        if let postObjects = postObjects {
            return postObjects.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath as IndexPath) as! PostCell
        let post = postObjects![indexPath.row]
        
        //grabbing image
        let image = post["picture"] as! PFFile
        image.getDataInBackground { (data: Data?, error: Error?) in
            if let data = data {
                cell.postImage.image = UIImage(data: data)
            }
        }
        cell.captionLabel.text = post["caption"] as? String ?? "default string" 

        
        return cell
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        PFUser.logOut()
        
        //go back to login screen
        self.dismiss(animated: true) { () -> Void in
            print("return to login")
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
