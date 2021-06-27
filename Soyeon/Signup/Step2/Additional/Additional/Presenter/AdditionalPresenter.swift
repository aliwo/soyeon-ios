//
//  AdditionalPresenter.swift
//  Soyeon
//
//  Created by 이재은 on 2021/03/08.
//  Copyright (c) 2021 ludus. All rights reserved.
//

import UIKit

protocol AdditionalPresenterInput: AdditionalInteractorOutput {

}

protocol AdditionalPresenterOutput: AnyObject {

    func displayAdditionalTableView(viewModel: AdditionalMatch.AdditionalViewModel)
}

final class AdditionalPresenter {

    private(set) weak var output: AdditionalPresenterOutput!

    // MARK: - Initializers

    init(output: AdditionalPresenterOutput) {
        self.output = output
    }
}
 
// MARK: - AdditionalPresenterInput

extension AdditionalPresenter: AdditionalPresenterInput {
 
    // MARK: - Presentation logic
    func presentAdditionalList(list: [AdditionalMatch.AdditionalMatchingType]) {
        let viewModel = AdditionalMatch.AdditionalViewModel(list: list)
        output.displayAdditionalTableView(viewModel: viewModel)
    }
}
