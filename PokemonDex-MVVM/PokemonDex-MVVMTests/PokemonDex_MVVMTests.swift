//
//  PokemonDex_MVVMTests.swift
//  PokemonDex-MVVMTests
//
//  Created by Jeong Deokho on 9/10/24.
//

import XCTest
@testable import PokemonDex_MVVM

final class PokemonDex_MVVMTests: XCTestCase {
    
    var networkService: MockNetworkService!
    var coordinator: MockCoordinator!
    var viewModel: DexViewModel!
    
    override func setUp() {
        networkService = MockNetworkService()
        coordinator = MockCoordinator()
        viewModel = DexViewModel(
            netWorkService: networkService,
            coordinator: coordinator
        )
    }
    
    override func tearDown() {
        networkService = nil
        coordinator = nil
        viewModel = nil
    }
    
    func test_succeed_fetchDexCellViewModels() async {
        // given
        let mockModels: [PokemonModel?] = [
            PokemonModel(id: 1, name: "name1", imageURL: "imageURL1", type: "fire"),
            PokemonModel(id: 2, name: "name2", imageURL: "imageURL2", type: "water")
        ]
        networkService.setModel(mockModels)
        
        // when
        await viewModel.fetchCellViewModels()
        
        // then
        XCTAssertEqual(viewModel.filteredCellViewModels.count, 2)
        XCTAssertEqual(viewModel.filteredCellViewModels[0].id, 1)
        XCTAssertEqual(viewModel.filteredCellViewModels[1].id, 2)
        XCTAssertEqual(viewModel.filteredCellViewModels[0].name, "name1")
        XCTAssertEqual(viewModel.filteredCellViewModels[1].name, "name2")
        XCTAssertEqual(viewModel.filteredCellViewModels[0].imageURL, "imageURL1")
        XCTAssertEqual(viewModel.filteredCellViewModels[1].imageURL, "imageURL2")
        XCTAssertEqual(viewModel.filteredCellViewModels[0].typeName, "fire")
        XCTAssertEqual(viewModel.filteredCellViewModels[1].typeName, "water")
        XCTAssertEqual(viewModel.filteredCellViewModels[0].backgroundColor, .red)
        XCTAssertEqual(viewModel.filteredCellViewModels[1].backgroundColor, .blue)
    }
    
    func test_failed_fetchDexCellViewModels() async {
        // given
        networkService.setError(.defaultError)
        
        // when
        await viewModel.fetchCellViewModels()
        
        XCTAssertEqual(viewModel.isShowAlert, true)
        XCTAssertEqual(viewModel.alertMessage, MockError.defaultError.localizedDescription)
    }
    
    func test_set_filterModels() async {
        // given
        let mockModels: [PokemonModel?] = [
            PokemonModel(id: 1, name: "name1", imageURL: "imageURL1", type: "fire"),
            PokemonModel(id: 2, name: "name2", imageURL: "imageURL2", type: "fire"),
            PokemonModel(id: 3, name: "name3", imageURL: "imageURL3", type: "fire"),
            PokemonModel(id: 4, name: "name4", imageURL: "imageURL4", type: "fire")
        ]
        networkService.setModel(mockModels)
        
        // when
        await viewModel.fetchCellViewModels()
        
        // then
        XCTAssertEqual(viewModel.filterModels[0].title, "All")
        XCTAssertEqual(viewModel.filterModels[0].color, .black)
        XCTAssertEqual(viewModel.filterModels[1].title, "fire")
        XCTAssertEqual(viewModel.filterModels[1].color, .red)
    }
    
    func test_selectedFilter() async {
        // given
        let mockModels: [PokemonModel?] = [
            PokemonModel(id: 1, name: "name1", imageURL: "imageURL1", type: "fire"),
            PokemonModel(id: 2, name: "name2", imageURL: "imageURL2", type: "water")
        ]
        networkService.setModel(mockModels)
        
        // when
        await viewModel.fetchCellViewModels()
        viewModel.selectedFilterWords = "water"
        
        // then
        XCTAssertEqual(viewModel.filteredCellViewModels.count, 1)
        XCTAssertEqual(viewModel.filteredCellViewModels[0].id, 2)
        XCTAssertEqual(viewModel.filteredCellViewModels[0].name, "name2")
        XCTAssertEqual(viewModel.filteredCellViewModels[0].imageURL, "imageURL2")
        XCTAssertEqual(viewModel.filteredCellViewModels[0].typeName, "water")
        XCTAssertEqual(viewModel.filteredCellViewModels[0].backgroundColor, .blue)
    }
    
    func test_pushDetailView() async {
        // given
        let mockCellViewModel = DexCellViewModel(model: PokemonModel(id: 1, name: "name1", imageURL: "imageURL1", type: "fire"))
        
        // when
        viewModel.pushDetailView(cellViewModel: mockCellViewModel)
        
        // then
        XCTAssertEqual(coordinator.pushDestination.first, .pokemonDexDetail(mockCellViewModel))
    }
}
