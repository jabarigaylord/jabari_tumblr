	//
//  PhotosViewController.swift
//  jabari_tumblr
//
//  Created by Jabari on 5/5/18.
//  Copyright © 2018 Jabari. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tumblrTableView: UITableView!
    
    
    var posts: [[String: Any]] = [];
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        tumblrTableView.insertSubview(refreshControl, at: 0)
        
        tumblrTableView.delegate = self;
        tumblrTableView.dataSource = self;
        tumblrTableView.rowHeight = 200
        

        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main);
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData;
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let DataDict = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                let ResponseDict = DataDict["response"] as! [String:Any];
                self.posts = ResponseDict["posts"] as! [[String:Any]];
                self.tumblrTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
    }
    @objc func didPullToRefresh(_refreshControl: UIRefreshControl){
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.posts.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tumblrTableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell;
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0];
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.tumblrImageView.af_setImage(withURL: url!)
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController;
        
        let cell = sender as! UITableViewCell;
        
        let indexPath = tumblrTableView.indexPath(for: cell)!
        
        let post = posts[indexPath.row];
        let photos = post["photos"] as! [[String:Any]];
        let photo = photos[0];
        let originalSize = photo["original_size"] as! [String: Any];
        let urlString = originalSize["url"] as! String;
        
    
        
        
        vc.imageURL = URL(string: urlString);
        
    }
    
    

        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
