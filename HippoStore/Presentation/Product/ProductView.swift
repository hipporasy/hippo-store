//
//  ProductView.swift
//  HippoStore
//
//  Created by Marasy Phi on 11/1/23.
//

import Foundation
import SwiftUI

struct ProductView: View {
    
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .initial:
                Text("Initital")
            case .fetched:
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.products) { product in
                        Text(product.title)
                    }
                }
            case .loading:
                ProgressView("Loading")
            }
            
        }.onAppear {
            viewModel.loadProduct()
        }
    }
    
}

