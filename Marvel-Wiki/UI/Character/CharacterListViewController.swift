import UIKit
import RxSwift
import RxCocoa

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel: CharacterListViewModel
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        setupCollectionView()
        setupBindings()
        super.viewDidLoad()
    }
    
    init(viewModel: CharacterListViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchCharacters()
        super.viewDidAppear(animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBindings() {
        
        searchBar.rx.text
            .distinctUntilChanged()
            .debounce(0.3, scheduler: MainScheduler.instance)
            .subscribe ({ [unowned self] (query) in
                
                self.viewModel.searchCharacterWith(value: query.element as? String)
            })
            .disposed(by: self.disposeBag)
        
        viewModel
            .newElements
            .observeOn(MainScheduler.instance)
            .subscribe { [unowned self] _ in
                self.collectionView
                    .reloadSections(NSIndexSet(index: 0) as IndexSet)
            }
            .disposed(by: self.disposeBag)
    }
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CharacterListCell", bundle: nil), forCellWithReuseIdentifier: "characterListCell")
    }
}
extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterListCell", for: indexPath) as? CharacterListCell else {
            fatalError("Couldn'tdequeue cell")
        }
        cell.viewModel = viewModel.getCharacterCellViewModel(for: indexPath.row)
        
        if indexPath.row == viewModel.numberOfCells - 1 {
            viewModel.fetchCharacters()
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
