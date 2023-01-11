//
//  ProductView+ViewModel.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation
import Combine

extension ProductView {
    
    enum State {
        case initial
        case fetched
        case loading
    }
    
    class ViewModel: ObservableObject {
        
        @Published var products: [Product] = []
        @Published var state: State = .initial
        @Inject private var repository: StoreRepository
        private var cancellable = Set<AnyCancellable>()
        

        func loadProductAsync() async {
            do {
                let response = try await repository.fetchProducts()
                DispatchQueue.main.async {
                    self.products = response.products
                }
            } catch (let e) {
                print(e)
            }
            
        }
        
        func loadProduct() {
            state = .loading
            repository
                .fetchProducts()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { status in
                    self.state = .fetched
                    switch status {
                    case .failure(let error):
                        print(error)
//                        self.state = .error(.other(error))
                    case .finished:
                        print("Success")
//                        self.state = .fetched
                    }
                },
                      receiveValue: { (result) in
                    self.products = result.products
                })
                .store(in: &cancellable)
        }
        
    }
    
}
