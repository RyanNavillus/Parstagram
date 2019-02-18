//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Ryan Sullivan on 2/17/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground { (posts, error) in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell")
        if let postCell = cell as? PostTableViewCell {
            let post = posts[indexPath.row]
            if let user = post["author"] as? PFUser,
                let captiontext = post["caption"] as? String,
                let image = post["image"] as? PFFileObject,
                let urlString = image.url,
                let url = URL(string: urlString) {
                postCell.userNameLabel.text = user.username
                postCell.commentLabel.text = captiontext
                postCell.postImageView.af_setImage(withURL: url)
                return postCell
            }
        }
        return cell!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
