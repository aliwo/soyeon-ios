//
//  HomeViewController.swift
//  Soyeon
//
//  Created by junyeong-cho on 2021/05/20.
//  Copyright © 2021 ludus. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    typealias Profile = ProfileViewModel
    
    enum Section: Int {
        case suggestion
        case selection
        case chance
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var titleBarButtonItem: UIBarButtonItem = {
        let label = UILabel()
        label.text = "오늘의 인연"
        label.textColor = Colors.strongBlack.color()
        label.font = Fonts.nanumSquareR.size(20.0)
        let barButtonItem = UIBarButtonItem(customView: label)
        return barButtonItem
    }()
    
    private var pointBarButtonItem: UIBarButtonItem = {
        let button = UIButton()
        button.setTitleColor(Colors.strongBlack.color(), for: .normal)
        button.setImage(UIImage(named: "icoItemGnbNormal"), for: .normal)
        button.setTitle("300", for: .normal)
        button.titleLabel?.font = Fonts.nanumSquareR.size(18.0)
        button.tintColor = UIColor.clear
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }()
    
    private var alarmBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage(named: "icoAlarmGnbNew")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: nil,
            action: nil
        )
        return barButtonItem
    }()
    
    private lazy var dataSource = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    private func setupLayout() {
        navigationItem.leftBarButtonItem = titleBarButtonItem
        navigationItem.rightBarButtonItems = [alarmBarButtonItem, pointBarButtonItem]
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = Theme.backgroundColor
        collectionView.register(
            MatchSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        collectionView.register(
            MatchSectionFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "footer"
        )
        collectionView.register(
            ProfileCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        collectionView.collectionViewLayout = createLayout()
        applySnapshots()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            switch sectionKind {
            case .suggestion, .selection:
                return self.createListLayout()
            case .chance:
                return self.createGridLayout()
            }
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func createListLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: ViewMetrics.listItemSize)
        let groupHeight = NSCollectionLayoutDimension.fractionalWidth(0.5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(112.0)
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = ViewMetrics.listSectionInset
        section.boundarySupplementaryItems = [headerItem]
        return section
    }
    
    private func createGridLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: ViewMetrics.gridItemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(162.0),
                                               heightDimension: .absolute(291.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(112.0)
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(48.0)
        )
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = ViewMetrics.gridItemSpacing
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = ViewMetrics.listSectionInset
        section.boundarySupplementaryItems = [headerItem, footerItem]
        return section
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, Profile> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Profile>(
            collectionView: collectionView) { (collectionView, indexPath, profile) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProfileCell
            if let section = Section(rawValue: indexPath.section) {
                cell?.configure(
                    layoutDirection: section != .chance ? .horizontal : .vertical,
                    profileViewModel: profile
                )
            }
            return cell
        }
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, elementKind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            
            if elementKind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "header",
                    for: indexPath
                ) as? MatchSectionHeaderView else { return nil }
                headerView.configure(title: section.title, subTitle: section.subTitle)
                return headerView
            } else {
                guard let footerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: "footer",
                    for: indexPath
                ) as? MatchSectionFooterView else { return nil }
                return footerView
            }
        }
        return dataSource
    }
    
    func applySnapshots(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Profile>()
        snapshot.appendSections([.suggestion])
        snapshot.appendItems([
            Profile(id: 1, nickName: "오늘 가입했어요1", age: 28, height: 168, occupation: "공기업", bio: "센스있는 해결사 고양이"),
            Profile(id: 2, nickName: "오늘 가입했어요2", age: 30, height: 168, occupation: "공기업", bio: "센스있는 해결사 고양이")
        ], toSection: .suggestion)
        
        snapshot.appendSections([.selection])
        snapshot.appendItems([
            Profile(id: 3, nickName: "오늘 가입했어요3", age: 28, height: 168, occupation: "공기업", bio: "센스있는 해결사 고양이")
        ], toSection: .selection)
        
        snapshot.appendSections([.chance])
        snapshot.appendItems([
            Profile(id: 4, nickName: "오늘 가입했어요4", age: 28, height: 168, occupation: "공기업", bio: "센스있는 해결사 고양이"),
            Profile(id: 5, nickName: "오늘 가입했어요4", age: 28, height: 168, occupation: "공기업", bio: "센스있는 해결사 고양이"),
            Profile(id: 6, nickName: "오늘 가입했어요4", age: 28, height: 168, occupation: "공기업", bio: "센스있는 해결사 고양이")
        ], toSection: .chance)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

private extension HomeViewController.Section {
    var title: String {
        switch self {
        case .suggestion:
            return "소연이\n제안하는 인연"
        case .selection:
            return "당신이\n선택한 인연"
        case .chance:
            return "우연히 만난\n인연"
        }
    }
    
    var subTitle: String {
        switch self {
        case .suggestion:
            return "당신의 맞춤 인연을 찾아드려요"
        case .selection:
            return "이상형 정보를 토대로 추천해드려요"
        case .chance:
            return "어쩌면 당신의 인연이 이곳에!"
        }
    }
}

private extension HomeViewController {
    enum Theme {
        static let backgroundColor = UIColor(
            red: 252/255,
            green: 252/255,
            blue: 252/255,
            alpha: 1.0
        )
        static let separatorColor = Colors.buttonDisabled.color()
    }
    
    enum ViewMetrics {
        static let listItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(140.0)
        )
        static let listItemSpacing: CGFloat = 12.0
        static let listSectionInset = NSDirectionalEdgeInsets(
            top: 16.0,
            leading: 18.0,
            bottom: 12.0,
            trailing: 18.0
        )
        
        static let gridItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(162.0),
            heightDimension: .absolute(291.0)
        )
        static let gridItemSpacing: CGFloat = 14.0
    }
}
