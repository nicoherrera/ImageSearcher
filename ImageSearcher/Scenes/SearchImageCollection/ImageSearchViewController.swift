//
//  ImageSearchViewController.swift
//  ImageSearcher
//
//

import UIKit
import RxSwift
import RxCocoa

class ImageSearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultLabel: UILabel!
    
    private let viewModel = ImageSearchViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: ImageViewCell.Identifier, bundle: nil), forCellWithReuseIdentifier: ImageViewCell.Identifier)
        bindViewModel()
    }
    
    
    func bindViewModel() {
        configCollectionView()
        
        configSearchBar()
        
        self.viewModel.errorObservable.subscribe { [weak self] alert in
            self?.showAlertMessage(titleStr: alert.title, messageStr: alert.body)
        }.disposed(by: self.disposeBag)
        
        
        self.viewModel.images.map({ $0.count > 0}).bind(to: self.noResultLabel.rx.isHidden).disposed(by: self.disposeBag)
        
        self.viewModel.loadingObservable.subscribe(onNext: { enabled in
            self.toggleLoading(enable: enabled)
        }).disposed(by: disposeBag)
    }
    
    func configCollectionView() {
        self.viewModel.images
            .bind(to: collectionView.rx
                .items(cellIdentifier: ImageViewCell.Identifier, cellType: ImageViewCell.self))
        { row, photo, cell in
            let model = ImageViewCellModel(imageURL: photo.previewURL, description: photo.tags)
            cell.model = model
        }.disposed(by: self.disposeBag)
        
        self.collectionView.delegate = self
        
        self.collectionView.rx
            .willDisplayCell
            .map { $1.item }
            .distinctUntilChanged()
            .withLatestFrom(self.viewModel.images) { item, photos in
                return item == photos.count - 2
            }.filter { $0 }
            .subscribe { [weak self] isLastest in
                self?.viewModel.requestNewPage()
            }.disposed(by: disposeBag)
        
        Observable
            .zip(collectionView.rx.itemSelected,
                 collectionView.rx.modelSelected(Photo.self)
            ).bind{ [weak self] indexPath, model in
                if let self = self {
                    self.openDetailScreen(with: model, allImages: self.viewModel.images.value, index: indexPath.item)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func configSearchBar() {
        self.searchBar.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: self.viewModel.searchText)
            .disposed(by: self.disposeBag)
        
        self.searchBar.rx.searchButtonClicked
            .asDriver()
            .drive(onNext: { [weak searchBar] in
                searchBar?.resignFirstResponder()
            })
            .disposed(by: self.disposeBag)
    }
    
    //MARK: Navigation
    func openDetailScreen(with image: Photo, allImages: [Photo], index: Int) {
        let model = ImageDetailViewModel(image, images: allImages, index: index)
        let vc = ImageDetailViewController.instantiate(with: model)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ImageSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
