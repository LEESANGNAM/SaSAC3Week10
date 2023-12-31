//
//  SearchViewController.swift
//  SaSAC3Week10
//
//  Created by 이상남 on 2023/09/21.
//

import UIKit
import SnapKit
import Kingfisher

class SearchViewController: UIViewController, UISearchBarDelegate{
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureTagLayout())
    
    let list = ["이모티콘","새싹","추석","asdasdsad","안녕","하세요","이것은","글자입니다","코래밥"]
    
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>?
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tableView = UITableView()
//        tableView.rowHeight = 50
//        tableView.estimatedRowHeight = 50 //
        view.backgroundColor = .systemGray
        configureHierarchy()
        configureLayout()
        configureDataSouce()
        let bar = UISearchBar()
        bar.delegate = self
        navigationItem.titleView = bar
//        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Network.shared.requestConvertible(type: Photo.self, api: .search(query: searchBar.text!)) { response in
            switch response {
            case .success(let success):
                
                let ratios = success.results.map {
                    Ratio(ratio: $0.width / $0.height)
                }
                
                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 10, contentWidth: self.view.frame.width - 80)
                
                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                self.updateSnapShot(success)
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func updateSnapShot(_ item: Photo){
        var snapshot = NSDiffableDataSourceSnapshot<Int,PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(item.results)
        dataSource?.apply(snapshot)
    }
    
    func configureHierarchy(){
        view.addSubview(collectionView)
        
    }
    
    func configureLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    func configureDataSouce(){
        let registration = UICollectionView.CellRegistration<SearchCollectionViewCell,PhotoResult>(handler: { cell, indexPath, itemIdentifier in
            cell.imageView.image = UIImage(systemName: "star")
            cell.imageView.tintColor = .yellow
            cell.label.text = "\(itemIdentifier.created_at)번"
            if let url = URL(string: itemIdentifier.urls.thumb){
                cell.imageView.kf.setImage(with: url)
            }
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }
    
   
    
    func configurePinterestLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(100)) // group height 가 80이라 80
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        // .absolute(80) : 절대적인 사이즈, fractionalWidth : 상대적인 사이즈
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // inset
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = configuration
        
        return layout
    }
    func configureTagLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0)) // group height 가 80이라 80

        let item = NSCollectionLayoutItem(layoutSize: itemSize)


        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(30))
        // .absolute(80) : 절대적인 사이즈, fractionalWidth : 상대적인 사이즈
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = .fixed(10)



        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // inset
        section.interGroupSpacing = 10

        let layout = UICollectionViewCompositionalLayout(section: section)

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        layout.configuration = configuration
        return layout
    }
//    func configureCollectionLayout() -> UICollectionViewLayout {
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0)) // group height 가 80이라 80
//
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
//        // .absolute(80) : 절대적인 사이즈, fractionalWidth : 상대적인 사이즈
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
//        group.interItemSpacing = .fixed(10)
//
//
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // inset
//        section.interGroupSpacing = 10
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//
//        let configuration = UICollectionViewCompositionalLayoutConfiguration()
//        configuration.scrollDirection = .horizontal
//        layout.configuration = configuration
//        return layout
//    }
//
//    func configureCollectionLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 50, height: 50)
//        layout.scrollDirection = .vertical
//        return layout
//    }
    
    
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
//        cell.label.text = "\(list[indexPath.item])번"
//        return cell
//    }
    
}
//class SearchViewController: UIViewController{
//    let scrollView  = UIScrollView()
//    let contentView = UIView()
//
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        configureStackView()
//        setConstraints()
//        setContentView()
//    }
//    func configureStackView(){
//        scrollView.bounces = false
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//    }
//
//    func setConstraints(){
//        scrollView.backgroundColor = .systemRed
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//
//        contentView.backgroundColor = .systemMint
//        contentView.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.verticalEdges.equalToSuperview()
//        }
//
//
//    }
//
//    func setContentView(){
//        contentView.addSubview(imageView)
//        contentView.addSubview(label)
//        contentView.addSubview(button)
//
//        imageView.backgroundColor = .systemOrange
//        label.backgroundColor = .magenta
//        button.backgroundColor = .systemBlue
//        label.numberOfLines = 0
//        label.text = "asjl\ndkas/ndsfjlkajklfsjfdskaljk/n;fsjdfskljsdfanksdjfl;ksdj/nf;ldsjf;lsdj;flkjslk;fjl;sdfan\nsjldkasdsfjlkaj/nklfsjfdskaljk;fsjdfskljsdfnalksdjf///,,,.caspkdpqkw/./nl;ksdjf;ld\n/nsjf;lsdj;flkjslk;fjl;sdfasjldka/nsdsfjlkaklf/nsjfdskaljk;fsjdfskljsdfalksdjfl;ksdjfndsjf/n;lsdj;flkjslk;fjl;sdfasjldkasdsfjlknjklfsjf/ndskaljk;f/nsjdfskljsdfalksdjfl;ks\ndjf;ldsjf;ls/ndj;flkjslk;fjl;sdfasjldkasdsfjlkajklfsjfdsk/naljk;fs/njdfskljsdfalksdjfln\nsdjf;ldsjf;lsdj;/nflkjsl/nk;fjl;asjldkasdnsfjlkajklfsjfdskaljk;f/nsjd/nfskljsdfalksdj\nfl;ksdjf;ldsjf;lsdj;flkjsl/nk;asdsfjlkajklfjfdskaljk;fsjdfskljsdfalks/ndjfl;ksdj/nf;lndsjf;lsdj;flkjslk;fjl;sdfasjldkajk;fsjdfsklnjsdfalksdjfl;ksdj/nf;ldsjf;lsdj;flkjslk;fjlndfasjldkasdsfjlkaj/nklfsjfdskaljk;fsjdfsk\nljsdfalksdjfl;ksdjf;ld/nsjf;lsdj;flkjslk;fj;sdfasjldkasdsfjlkajklf/nsjfdskalj\nk;fsjdfsn\n;ksdjf;ldsjf/n;lsdj;flkjslk;f;sd\nfasjldkasdsfjlkajklfsjf/ndskaljk;fsjdfnkljs\ndfalksdjfl;ksdjf;ldsjf;ls/ndj;flkjslk;njl;sn\ndfasjldkasdsfjlkajklfsjfdsk/naljk;fsjd\nfskn\nljsdfalksdjfl;ksdjf;ldsjf;lsdj;/nflkjslk\n;fjl;asjldkasdsfjlkajklfsjfdsk\naljk;f/nsjdfs\nkljsdfalksdjfl;ksdjf;ldsjf;l\nsdj;flkjsl/nk;a\nsdsfjlkajklfsjfdskaljk;fsj\ndfskljsdfalksdjfl\n;ksdj/nf;ldsjf;lsdj;flkj\nslk;fjl;sdfasjldkaj\nk;fsjdfskljsdfalksdjfl\n;ksdj/nf;ldsjf;lsdj;f\nlkjslk;fjl;sdfasjldk\nasdsfjlkaj/nklfsjfdskal\njk;fsjdfskljsdfalk\nsdjfl;ksdjf;ld/nsjf;lsdj;\nflkjslk;fjl;sdfa\nsjldkasdsfjlkajklf/nsjfdska\nljk;fsjdfskljs\ndfalksdjfl;ksdjf;ldsjf/n;lsdj\n;flkjslk;fjl\n;sdfasjldkasdsfjlkajklfsjf/ndsk\naljk;fsjdf\nskljsdfalksdjfl;ksdjf;ldsjf;ls/nd\nj;flkjsl\nk;fjl;sdfasjldkasdsfjlkajklfsjfdsk/\nnaljk;fsjdfskljsdfalksdjfl;ksdjf;ldsjf;lsdj\n;/nflkjslk;fjl;asjldkasdsfjlkajklfsjfdskalj\nk;f/nsjdfskljsdfalksdjfl;ksdjf;ldsjf;lsdj;f\nlkjsl/nk;asdsfjlkajklfsjfdskaljk;fsjdfskljs\ndfalksdjfl;ksdj/nf;ldsjf;lsdj;flkjslk;fjl;s\ndfasjldkajk;fsjdfskljsdfalksdjfl;ksdj/nf;ld\nsjf;lsdj;flkjslk;fjl;sdfasjldkasdsfjlkaj/nk\nlfsjfdskaljk;fsjdfskljsdfalksdjfl;ksdjf;ld/\nnsjf;lsdj;flkjslk;fjl;sdfasjldkasdsfjlkajkl\nf/nsjfdskaljk;fsjdfskljsdfalksdjfl;ksdjf;ld\nsjf/n;lsdj;flkjslk;fjl;sdfasjldkasdsfjlkajk\nlfsjf/ndskaljk;fsjdfskljsdfalksdjfl;ksdjf;l\ndsjf;ls/ndj;flkjslk;fjl;sdfasjldkasdsfjlkaj\nklfsjfdsk/naljk;fsjdfskljsdfalksdjfl;ksdjf;\nldsjf;lsdj;/nflkjslk;fjl;asjldkasdsfjlkajkl\nfsjfdskaljk;f/nsjdfskljsdfalksdjfl;ksdjf;ld\nsjf;lsdj;flkjsl/nk;asdsfjlkajklfsjfdskaljk;\nfsjdfskljsdfalksdjfl;ksdj/nf;ldsjf;lsdj;flk\njslk;fjl;sdfasjldkajk;fsjdfskljsdfalksdjfl;\nksdj/nf;ldsjf;lsdj;flkjslk;fjl;sdfasjldkasd\nsfjlkaj/nklfsjfdskaljk;fsjdfskljsdfalksdjfl\n;ksdjf;ld/nsjf;lsdj;flkjslk;fjl;sdfasjldkas\ndsfjlkajklf/nsjfdskaljk;fsjdfskljsdfalksdjf\nl;ksdjf;ldsjf/n;lsdj;flkjslk;fjl;sdfasjldka\nsdsfjlkajklfsjf/ndskaljk;fsjdfskljsdfalksdj\nfl;ksdjf;ldsjf;ls/ndj;flkjslk;fjl;sdfasjldk\nasdsfjlkajklfsjfdsk/naljk;fsjdfskljsdfalksd\njfl;ksdjf;ldsjf;lsdj;/nflkjslk;fjl;asjldkas\ndsfjlkajklfsjfdskaljk;f/nsjdfskljsdfalksdjf\nl;ksdjf;ldsjf;lsdj;flkjsl/nk;asdsfjlkajklfsjfdskaljk;fsjdfskljsdfalksdjfl;ksdj/nf;ldsjf;lsdj;flkjslk;fjl;sdfasjldkasdsfjlkaj/nklfsjfdskaljk;fsjdfskljsdfalksdjfl;ksdjf;ld/nsjf;lsdj;flkjslk;fjl;sdfasjldkasdsfjlkajklf/nsjfdskaljk;fsjdfskljsdfalksdjfl;ksdjf;ldsjf/n;lsdj;flkjslk;fjl;sdfasjldkasdsfjlkajklfsjf/ndskaljk;fsjdfskljsdfalksdjfl;ksdjf;ldsjf;ls/ndj;flkjslk;fjl;sdfasjldkasdsfjlkajklfsjfdsk/naljk;fsjdfskljsdfalksdjfl;ksdjf;ldsjf;lsdj;/nflkjslk;fjl;asjldkasdsfjlkajklfsjfdskaljk;f/nsjdfskljsdfalksdjfl;ksdjf;ldsjf;lsdj;flkjsl/nk;fjl;sdfasjldkasdsfjlkajklfsjfdskaljk;fsjd/nfskljsdfalksdjfl;ksdjf;ldsjf;lsdj;flkjslk;f/njl;sdfasjldkasdsfjlkajklfsjfdskaljk;fsjdfsk/nksdjfl;ksdjf;ldsjf;lsdj;flkjslk;fjl;sdfasjldkasdsfjlkajklfsjfdskaljk;fsjdfskljsdfalksdjfl;ksdjf;ldsjf;lsdj;flkjslk;fjl;sdfasjldkasdsfjlkajklfsjfdskaljk;fsjdfskljsdfalksdjfl;ksdjf;ldsjf;lsdj;flkjslk;fjl;sdf"
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView).inset(10)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//    }
//}
////class SearchViewController: UIViewController{
////
////    let scrollView  = UIScrollView()
////    let stackView = UIStackView()
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        view.backgroundColor = .white
////        setHierarchy()
////        configureStackView()
////        setConstraints()
////
////    }
////
////    func setHierarchy(){
////        view.addSubview(scrollView)
////        scrollView.addSubview(stackView)
////        stackView.spacing = 20
////    }
////
////    func setConstraints(){
////        scrollView.backgroundColor = .systemBlue
////        scrollView.snp.makeConstraints { make in
////            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
////            make.height.equalTo(70)
////        }
////        stackView.backgroundColor = .systemYellow
////        stackView.snp.makeConstraints { make in
////            make.horizontalEdges.equalToSuperview().inset(20)
////            make.verticalEdges.equalToSuperview().inset(10)
////            make.height.equalTo(50)
////        }
////    }
////
////    func configureStackView(){
////        let label1 = UILabel()
////        label1.text = "안녕11111하세요"
////        label1.textColor = .black
////        label1.backgroundColor = .systemRed
////        label1.layer.cornerRadius = 20
////        label1.clipsToBounds = true
////        stackView.addArrangedSubview(label1)
////
////        let label2 = UILabel()
////        label2.text = "안녕2222222222하세요"
////        label2.textColor = .black
////        label2.backgroundColor = .systemOrange
////        label2.layer.cornerRadius = 20
////        label2.clipsToBounds = true
////        stackView.addArrangedSubview(label2)
////
////        let label3 = UILabel()
////        label3.text = "안녕3333333333하세요"
////        label3.textColor = .black
////        label3.backgroundColor = .systemYellow
////        label3.layer.cornerRadius = 20
////        label3.clipsToBounds = true
////        stackView.addArrangedSubview(label3)
////
////        let label4 = UILabel()
////        label4.text = "안녕444444444하세요"
////        label4.textColor = .black
////        label4.backgroundColor = .systemGreen
////        label4.layer.cornerRadius = 20
////        label4.clipsToBounds = true
////        stackView.addArrangedSubview(label4)
////
////        let label5 = UILabel()
////        label5.text = "안녕555555555하세요"
////        label5.textColor = .black
////        label5.backgroundColor = .systemIndigo
////        label5.layer.cornerRadius = 20
////        label5.clipsToBounds = true
////        stackView.addArrangedSubview(label5)
////
////    }
////
////}
////
