import UIKit

final class CharacterViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: CharacterViewModelProtocol = CharacterViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(10)
        let cellsPerLine = CGFloat(2)
        layout.sectionInset = UIEdgeInsets(top: spacing,
                                           left: spacing,
                                           bottom: spacing,
                                           right: spacing)
        let cellSize = (view.bounds.width - (spacing * 3)) / cellsPerLine
        layout.itemSize = CGSize(width: cellSize,
                                 height: cellSize)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(CharacterCell.self,
                                forCellWithReuseIdentifier: CharacterCell.identifier)
        return collectionView
    }()
    
    private var spinnerView = UIActivityIndicatorView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isFiltering: Bool {
        return searchController.isActive && !isEmpty
    }
    private var isEmpty: Bool {
        guard
            let text = searchController.searchBar.text
        else { return false }
        return text.isEmpty
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        showSpinner(in: view)
        fetchData()
    }
    
    //MARK: - Actions
    
    private func setupNavigationBar() {
        setupNavigationBar(name: "Characters",
                           backAction: #selector(didTapBackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-filter-51"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapRightBarButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.titleColor()
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             bottom: view.bottomAnchor)
        collectionView.backgroundColor = UIColor.backgroundColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите имя"
        searchController.searchBar.tintColor = .white
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.startAnimating()
        spinnerView.center = view.center
        spinnerView.hidesWhenStopped = true
        view.addSubview(spinnerView)
    }
    
    private func fetchData() {
        viewModel.fetchData(urlString: ApiClient.baseUrl) { [weak self] in
            self?.collectionView.reloadData()
            self?.spinnerView.stopAnimating()
        }
    }
    
    @objc private func didTapRightBarButton() {
        let vc = FilterViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionView Extensions

extension CharacterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        isFiltering ? viewModel.filteredNumberOfRows : viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier,
                                                      for: indexPath) as! CharacterCell
        cell.viewModel = isFiltering ?
            viewModel.filterViewModelCell(index: indexPath) :
            viewModel.viewModelCell(index: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = DetailCharacterVC()
        vc.viewModel = isFiltering ?
            viewModel.filteredDetailViewModel(index: indexPath) :
            viewModel.detailViewModel(index: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath]) {
        let url = viewModel.rickAndMorty?.info.next ?? ""
        for index in indexPaths {
            if index.row >= viewModel.characters.count - 1 {
                viewModel.fetchData(urlString: url) { [weak self] in
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

//MARK: - UISearchResultsUpdating
extension CharacterViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.filterCharachter = viewModel.characters.filter {
            $0.name.lowercased().contains(searchText.lowercased())
            }
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - Delegate
extension CharacterViewController: FilterViewContollerDelegate {
    
    func sendDelegateItems(gender: String, status: String) {
        viewModel.characters.removeAll()
        let filterURL = ApiClient.absoluteUrlString(status: status,
                                                    gender: gender)
        viewModel.fetchData(urlString: filterURL) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

