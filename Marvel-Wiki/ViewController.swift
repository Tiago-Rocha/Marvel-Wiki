//
//  ViewController.swift
//  Marvel-Wiki
//
//  Created by Tiago Rocha on 28/04/2019.
//  Copyright © 2019 Tiago Rocha. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    var mAPi: MarvelAPI?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cl(_ sender: Any) {
        
        let vc = DependencyGraph().getCharacterListViewController()
        
        present(vc, animated: true, completion: nil)
    }
}

