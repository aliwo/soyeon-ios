//
//  LoginViewController.swift
//  Soyeon
//
//  Created by 이재은 on 2021/01/02.
//  Copyright (c) 2021 ludus. All rights reserved.
//

import UIKit

protocol LoginViewControllerInput: LoginPresenterOutput {

}

protocol LoginViewControllerOutput {
    func displayLoginOnLoad()
}

final class LoginViewController: SignupStepViewController<Login.ViewData> {
    var output: LoginViewControllerOutput!
    var router: LoginRouterProtocol!

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Initializers
    init(configurator: LoginConfigurator = LoginConfigurator.shared) {
        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    // MARK: - Configurator
    private func configure(configurator: LoginConfigurator = LoginConfigurator.shared) {
        configurator.configure(viewController: self)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad() 
        doLoginOnLoad()
    }
     
    // MARK: - Load data
    func doLoginOnLoad() {
        output.displayLoginOnLoad()
    }

    // MARK: - Function
    private func didTappedNaver() {

    }

    private func didTappedKakao() {
        LoginManager.shared.connect(.kakao)
    }

    private func didTappedGoggle() {

    }

    private func didTappedApple() {

    }
    @IBAction func didTap(_ sender: Any) {
        router.routeToPrivatePolicy()
    }
    
}

// MARK: - LoginPresenterOutput
extension LoginViewController: LoginViewControllerInput {

    // MARK: - Display logic
    func displayLoginTableView(viewModel: Login.LoginViewModel) {

    }
}

// MARK: - UITableViewDataSource
extension LoginViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return Login.Platform.allCases.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let platformCell = tableView
                .dequeueReusableCell(withIdentifier: "LoginPlatformCell",
                                     for: indexPath) as? LoginPlatformCell else {
            return UITableViewCell()
        }

        if let platform = Login.Platform(rawValue: indexPath.row) {
            platformCell.setProperties(platform)
        }

        return platformCell
    }
}

// MARK: - UITableViewDelegate
extension LoginViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        switch Login.Platform(rawValue: indexPath.row) {
        case .naver:
            didTappedNaver()
        case .kakao:
            didTappedKakao()
        case .google:
            didTappedGoggle()
        case .apple:
            didTappedApple()
        default:
            break
        }
    }
}
