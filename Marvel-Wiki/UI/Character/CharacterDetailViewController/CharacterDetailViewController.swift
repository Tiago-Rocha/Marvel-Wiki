import UIKit
import Kingfisher
class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let viewModel: CharacterDetailViewModel
    
    override func viewDidLoad() {
        
        setupLayout()
        
        super.viewDidLoad()
    }
    
    init(viewModel: CharacterDetailViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        title = viewModel.name
        descriptionLabel.text = viewModel.description
        if let _imageURL = viewModel.imageURL {
            
            imageView.kf.setImage(with: _imageURL) 
        }
        
    }
}
