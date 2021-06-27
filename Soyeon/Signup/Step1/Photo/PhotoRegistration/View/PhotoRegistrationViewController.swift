//
//  PhotoRegistrationViewController.swift
//  Soyeon
//
//  Created by 이재은 on 2021/02/07.
//  Copyright (c) 2021 ludus. All rights reserved.
//

import UIKit
import Photos

final class PhotoRegistrationViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var guidanceButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var mainProfileView: UIView!
    @IBOutlet private weak var mainProfileImageView: UIImageView!
    @IBOutlet private weak var completeButton: UIButton!
    @IBOutlet private weak var mainProfileMarkLabel: UILabel!

    private enum ViewMetrics {
        static let cellCornerRadius: CGFloat = 4
        static let buttonCornerRadius: CGFloat = 23
        static let cellBorderWidth: CGFloat = 1
        static let collectionViewMargin: CGFloat = 86
        static let oneLineCellCount: CGFloat = 3
        static let cellSize: CGFloat = (UIScreen.main.bounds.width - collectionViewMargin) / oneLineCellCount
    }

    // MARK: - Property

    var router: PhotoRegistrationRouterProtocol!

    private let imagePickerManager = ImagePickerManager()
    private var maxImageCount: Int = 10
    private var defaultImageCount: Int = 4
    private var selectedIndex: Int?
    private var userImages = [UIImage]() {
        didSet {
            mainProfileImageView.image = userImages.first
        }
    }

    // MARK: - Initializers

    init(configurator: PhotoRegistrationConfigurator = PhotoRegistrationConfigurator.shared) {
        super.init(nibName: nil, bundle: nil)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    // MARK: - Configurator

    private func configure(configurator: PhotoRegistrationConfigurator = PhotoRegistrationConfigurator.shared) {

        configurator.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: String(describing: ProfileCollectionViewCell.self), bundle: .main),
                                forCellWithReuseIdentifier: String(describing: ProfileCollectionViewCell.self))

        setupLayout()
    }

    // MARK: - IBAction

    @IBAction private func guidanceButtonDidTap(_ sender: UIButton) {
        router.navigationToPhotoGuide()
    }

    @IBAction private func completeButtonDidTap(_ sender: UIButton) {
        // 이미지 저장
        router.navigationToIdealType()
    }

    @IBAction private func mainProfileImageDidTap(_ sender: UIControl) {
        selectedIndex = -1
        presentSelectView()
    }

    // MARK: - Function

    private func setupLayout() {
        setNavigationTitle("프로필 작성하기")
        mainProfileView.layer.borderWidth = ViewMetrics.cellBorderWidth
        mainProfileView.layer.borderColor = Colors.soyeonBlue.cgColor()
        mainProfileView.setRadius(ViewMetrics.cellCornerRadius)
        mainProfileMarkLabel.setRadius(ViewMetrics.cellCornerRadius)
        mainProfileMarkLabel.clipsToBounds = true
        completeButton.setRadius(ViewMetrics.buttonCornerRadius)
        completeButton.clipsToBounds = true
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.setTitleColor(UIColor(named: "153153153"), for: .disabled)
        completeButton.setBackgroundColor(UIColor(named: "soyeonBlue")!, for: .normal)
        completeButton.setBackgroundColor(UIColor(named: "buttonDisabled")!, for: .disabled)
    }

    /// 카메라/앨범 선택 뷰 띄움
    private func presentSelectView() {
        if let selectView = storyboard?
            .instantiateViewController(withIdentifier: String(describing: ImagePickerSelectViewController.self)) as? ImagePickerSelectViewController {
            selectView.modalPresentationStyle = .overCurrentContext
            selectView.delegate = self
            present(selectView, animated: false, completion: nil)
        }
    }

    /// 이미지 넣기
    private func setImageView(to image: UIImage) {
        if var selectedIndex = selectedIndex {
            selectedIndex += 1
            if userImages.count > selectedIndex {
                userImages[selectedIndex] = image
                return
            }
        }
        userImages.append(image.resize(targetWidth: UIScreen.main.bounds.width))
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoRegistrationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if userImages.count < defaultImageCount {
            return defaultImageCount - 1
        } else if userImages.count == maxImageCount {
            return maxImageCount - 1
        } else {
            return userImages.count
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let profileCell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier,
                                     for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
        }

        if !completeButton.isEnabled && userImages.count > 1 {
            completeButton.isEnabled = true
        }

        let index = indexPath.row
        let image = userImages[safe: index + 1]
        profileCell.setProperties(index: index, profileImage: image)

        return profileCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoRegistrationViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: ViewMetrics.cellSize,
                      height: ViewMetrics.cellSize)
    }
}

// MARK: - UICollectionViewDelegate
extension PhotoRegistrationViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        presentSelectView()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension PhotoRegistrationViewController: ImagePickerSelectVCDelegate {

    func selectSourceType(_ sourceType: UIImagePickerController.SourceType) {
        presentImagePickerController(imagePickerManager, sourceType, true)
    }
}

// MARK: - ImagePickerPresentable
extension PhotoRegistrationViewController: ImagePickerPresentable {

    func getSelected(_ image: UIImage) {
        setImageView(to: image)
        collectionView.reloadData()
    }
}
