//
//  ContentView.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import SwiftUI

struct DexView: View {
    private enum Constants {
        enum String {
            static let retry = "Retry"
            static let Pokedex = "Pokedex"
        }
    }
    
    private let griditems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var isFirstAppear = true
    @State var viewModel: DexViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.filterModels, id: \.title) { model in
                                FilterButton(
                                    filterModel: model,
                                    isSelected: viewModel.selectedFilterWords == model.title
                                )
                                .onTapGesture {
                                    viewModel.selectedFilterWords = model.title
                                }
                            }
                        }
                    }
                    .padding(.bottom, -10)

                    LazyVGrid(columns: griditems, spacing: 20) {
                        ForEach(viewModel.filteredCellViewModels, id: \.id) { viewModel in
                            DexCellView(viewModel: viewModel)
                                .onTapGesture { _ in
                                    self.viewModel.pushDetailView(cellViewModel: viewModel)
                                }
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.isShowAlert, actions: {
                Button(Constants.String.retry) {
                    Task {
                        await viewModel.fetchCellViewModels()
                    }
                }
            })
            .task {
                guard isFirstAppear else { return }
                await viewModel.fetchCellViewModels()
                isFirstAppear = false
            }
            .navigationTitle(Constants.String.Pokedex)
        }
    }
}

struct FilterButton: View {
    let filterModel: (title: String, color: Color)
    let isSelected: Bool

    var body: some View {
        Text(filterModel.title)
            .padding(10)
            .background(filterModel.color)
            .foregroundColor(.white)
            .clipShape(.rect(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.black : Color.clear, lineWidth: 2)
            )
            .shadow(color: isSelected ? Color.black.opacity(0.3) : Color.clear, radius: 4, x: 0, y: 2)
            .padding(5)
    }
}
