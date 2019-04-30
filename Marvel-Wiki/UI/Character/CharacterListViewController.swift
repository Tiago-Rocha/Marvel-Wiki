import UIKit

class CharacterListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: CharacterListViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: CharacterListViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}