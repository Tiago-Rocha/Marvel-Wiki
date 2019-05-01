import UIKit

class CharacterListCell: UICollectionViewCell {

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
        
        print("setup layouuutt")
    }
}
