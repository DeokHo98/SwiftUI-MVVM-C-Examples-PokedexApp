//
//  DexCellView.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import SwiftUI

struct DexCellView: View { 
    let viewModel: DexCellViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                
                HStack {
                    Text(viewModel.typeName)
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white.opacity(0.25))
                        }
                        .frame(width: 100, height: 24)
                        .padding(.leading, -5)
                    
                    CachedAsyncImage(url: viewModel.imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding([.bottom, .trailing], 4)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 60)
                            .padding([.bottom, .trailing], 4)
                    }
                }
            }
        }
        .background(viewModel.backgroundColor)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: viewModel.backgroundColor, radius: 6)
    }
}
