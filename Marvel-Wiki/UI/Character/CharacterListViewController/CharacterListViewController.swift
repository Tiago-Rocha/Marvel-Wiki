import UIKit
import RxSwift
import RxCocoa

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var searchBar = UISearchBar()
    
    private let viewModel: CharacterListViewModel
    
    var disposeBag = DisposeBag()
    
    var isSearching = false
    
    var isFetching = false
    
    override func viewDidLoad() {
        
        setupSearchBar()
        setupCollectionView()
        setupBindings()
        super.viewDidLoad()
    }
    
    init(viewModel: CharacterListViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchBar() {
        
        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56)
        searchBar.placeholder = "Explore the Marvel World"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    func setupBindings() {
        
        searchBar.rx.text
            .distinctUntilChanged()
            .debounce(0.3, scheduler: MainScheduler.instance)
            .subscribe ({ [unowned self] (query) in
                
                if let _emptyQuery  = (query.element as? String)?.isEmpty {
                    self.isSearching = !_emptyQuery
                } else {
                    self.isSearching = false
                }
                self.viewModel.searchCharacterWith(value: query.element as? String)
            })
            .disposed(by: self.disposeBag)
        
        viewModel
            .newElements
            .observeOn(MainScheduler.instance)
            .subscribe { [unowned self] _ in
                self.isFetching = false
                self.collectionView
                    .reloadSections(NSIndexSet(index: 0) as IndexSet)
            }
            .disposed(by: self.disposeBag)
        
        
        viewModel
            .specificElement
            .observeOn(MainScheduler.instance)
            .subscribe { [unowned self] vm in
                guard let viewModel = vm.element else { return}
                
                let vc = CharacterDetailViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(vc, animated: true)
                
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
            fatalError("Couldn't dequeue cell")
        }
        cell.viewModel = viewModel.getCharacterCellViewModel(for: indexPath.row)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.getCharacterDetailsOn(position: indexPath.row)
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 {
            if !isFetching && !isSearching {
                viewModel.fetchCharacters()
            }
        }
    }
}
