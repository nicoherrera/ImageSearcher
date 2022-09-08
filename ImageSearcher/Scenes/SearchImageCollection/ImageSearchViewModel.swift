//
//  ImageSearchViewModel.swift
//  ImageSearcher
//
//

import Foundation
import RxSwift
import RxCocoa

class ImageSearchViewModel {
    
    let images = BehaviorRelay<[Photo]>(value: [])
    let dispose = DisposeBag()
    let errorObservable = PublishRelay<AlertMessage>()
    let searchText = BehaviorRelay<String>(value: "")
    
    var loadingObservable = PublishRelay<Bool>()
    
    private var totalHits: Int!
    private var page: Int!
    
    
    init() {
        self.cleanPage()
    
        searchText.subscribe { [weak self] _ in
            self?.clearResults()
            self?.getImages()
        }.disposed(by: dispose)
    }
    
    func requestNewPage() {
        page += 1
        self.getImages()
    }
    
    private func cleanPage() {
        self.page = 1
        self.totalHits = Int(FP_INFINITE)
    }
    
    private func getImages() {
        if images.value.count < totalHits {
            loadingObservable.accept(true)
            APIManager.searchImages(query: searchText.value, page: page).subscribe { [weak self] result in
                if let self = self {
                    var images = self.images.value
                    images.append(contentsOf: result.images)
                    self.totalHits = result.totalHits
                    self.images.accept(images)
                }
            } onError: { error in
                if let alert = error as? AlertMessage {
                    self.errorObservable.accept(alert)
                }
            } onCompleted: {
                self.loadingObservable.accept(false)
            }.disposed(by: self.dispose)
        }
    }
    
    private func clearResults() {
        images.accept([])
        self.cleanPage()
    }
}
