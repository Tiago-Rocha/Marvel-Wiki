import UIKit

class CharacterListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: CharacterCellViewModel? {
        didSet {
            setupLayout()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupLayout() {
        
        guard let _viewModel = viewModel else { return }
        
        nameLabel.text = _viewModel.characterName
        if let _imageURL = viewModel?.imageURL {
            imageView.kf.setImage(with: _imageURL)
        }
    }
}
