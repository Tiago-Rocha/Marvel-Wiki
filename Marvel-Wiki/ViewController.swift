//
//  ViewController.swift
//  Marvel-Wiki
//
//  Created by Tiago Rocha on 28/04/2019.
//  Copyright © 2019 Tiago Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mAPi: MarvelAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clientConfig = SwaggerClientAPI(basePath: "https://gateway.marvel.com", credential: nil)
        mAPi = MarvelAPI(config: clientConfig,
                  factory: AlamofireRequestBuilderFactory(),
                  authentication: MarvelAuthentication())
        

    }
    @IBAction func cl(_ sender: Any) {
        mAPi!.getCreatorCollection(name: nil, nameStartsWith: nil, modifiedSince: nil, comics: nil, series: nil, events: nil, stories: nil, orderBy: nil, limit: 10, offset: 10) { wrapper, error in
            
            wrapper
            print(wrapper)
            print(error)
            print("Returned call")
            
        }
    }
}

