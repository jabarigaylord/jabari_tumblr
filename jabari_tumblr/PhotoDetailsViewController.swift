//
//  PhotoDetailsViewController.swift
//  jabari_tumblr
//
//  Created by Jabari on 5/6/18.
//  Copyright © 2018 Jabari. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var tumblrImage: UIImageView!
    
    
    var posts: [String: Any]?
    
    var imageURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tumblrImage.af_setImage(withURL: imageURL)
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
