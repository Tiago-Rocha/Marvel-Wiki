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
        
        let clientConfig = SwaggerClientAPI(basePath: "https://gateway.marvel.com", credential: nil)
        mAPi = MarvelAPI(config: clientConfig,
                         factory: AlamofireRequestBuilderFactory(),
                         authentication: MarvelAuthentication())
    }
    
    @IBAction func cl(_ sender: Any) {
        
        let vm = CharacterListViewModel(characterRepository: CharacterRepository())
        let vc = CharacterListViewController(viewModel: vm)
        
        present(vc, animated: true, completion: nil)
//        mAPi!.getCreatorCollection(name: nil, nameStartsWith: nil, modifiedSince: nil, comics: nil, series: nil, events: nil, stories: nil, orderBy: nil, limit: 10, offset: 10) { wrapper, error in
//
//            guard
//                let _characterModel = wrapper?.data?.results?[0],
//                let _character = try? Character.builder().with(character: _characterModel).build(),
//                let _imageURL = _character.imageURL,
//                let _imageFormat = _character.imageFormat
//                else {
//                    print("failed to build character")
//                    return
//            }
//
//            guard let _url = URL(string: _imageURL + "/portrait_xlarge." + _imageFormat) else {
//                print("yo no url")
//                return
//            }
//
//            self.imageView.kf.setImage(with: ImageResource(downloadURL: _url))
//        }
    }
}

