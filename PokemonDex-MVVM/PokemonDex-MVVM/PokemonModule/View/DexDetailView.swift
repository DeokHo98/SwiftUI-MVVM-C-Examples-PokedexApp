//
//  DexDetailView.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/11/24.
//

import SwiftUI

struct DexDetailView: View {
    let viewModel: DexCellViewModel
    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                ZStack {
                    viewModel.backgroundColor
                    CachedAsyncImage(url: viewModel.imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.top, 100)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 200)
                    }
                }
                .frame(height: 300)
                
                Text(viewModel.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 10)
            
                Text(viewModel.typeName)
                    .font(.headline)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
}

