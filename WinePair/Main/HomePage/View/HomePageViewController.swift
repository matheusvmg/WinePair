//
//  HomePageViewController.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import UIKit

class HomePageViewController: UIViewController, BaseViewProtocol {
    var presenter: HomePagePresenterProtocol!
    
    var wineItems = [WineCardContent]()
    var wines = [Wine]()
    var alternativeDescriptionText: String?
    
    var isSearchFinished: Bool = false {
        didSet {
            setupHomePage()
        }
    }
    
    var isSearching: Bool = false {
        didSet {
            setupHomePage()
        }
    }
    
    lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.color = Colors.black
        loading.style = .large
        return loading
    }()
    
    lazy var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.white
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.title
        label.textColor = Colors.blue
        label.font = Fonts.Bold.xl
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.subtitle
        label.textColor = Colors.black
        label.font = Fonts.Medium.sm
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var inputPadding: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 50)
        return view
    }()
    
    lazy var searchInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 25
        textField.layer.borderColor = Colors.blue.cgColor
        textField.layer.borderWidth = 2
        textField.leftView = inputPadding
        textField.leftViewMode = .always
        textField.textColor = Colors.blue
        textField.attributedPlaceholder = NSAttributedString(string: Strings.searcInputPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : Colors.lightBlue])
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Strings.searchIconName), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 0)
        button.imageView?.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()
    
    lazy var wineGrid: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    
    lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wineGrid.register(WineCardTableViewCell.self, forCellReuseIdentifier: WineCardTableViewCell.identifier)
        self.view.backgroundColor = Colors.white
        configureLayout()
        setupSearchTextField()
        dismissKeyboard()
    }
    
    func configureLayout() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(subtitleLabel)
        self.view.addSubview(searchInput)
    }
    
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupSubtitleLabelConstraints()
        setupSearchInputConstraints()
        setupHomePage()
    }
    
    func startLoading() {
        self.isSearchFinished = false
        self.isSearching = true
    }
    
    func stopLoading() {
        self.isSearchFinished = true
        self.isSearching = false
    }
    
    func setErrorOrNoWine() {
        self.isSearchFinished = false
        self.isSearching = false
    }
    
    private func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardWhenCLick))
        tap.cancelsTouchesInView = false
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
    private func setupHomePage() {
        if isSearching {
            configureHomePageWhenIsSearching()
            return
        }
        
        if isSearchFinished {
            configureHomePageWhenSearchIsFinished()
        } else {
            configureHomePageWhenThereIsNoDataOrError()
        }
    }
    
    private func configureHomePageWhenThereIsNoDataOrError() {
        loadingView.removeFromSuperview()
        wineGrid.removeFromSuperview()
        self.view.addSubview(emptyView)
        setupEmptyViewConstraints()
    }
    
    private func configureHomePageWhenSearchIsFinished() {
        loading.stopAnimating()
        loadingView.removeFromSuperview()
        emptyView.removeFromSuperview()
        self.view.addSubview(wineGrid)
        setupWineGridConstraints()
    }
    
    private func configureHomePageWhenIsSearching() {
        emptyView.removeFromSuperview()
        wineGrid.removeFromSuperview()
        loadingView.addSubview(loading)
        self.view.addSubview(loadingView)
        setupLoadingViewConstraints()
        setupLoadingConstraints()
        loading.startAnimating()
    }
    
    private func setupSearchTextField() {
        searchInput.returnKeyType = UIReturnKeyType.done
        searchInput.rightView = searchButton
        searchInput.rightViewMode = .always
        searchInput.autocapitalizationType = .none
    }
    
    private func setupLoadingConstraints() {
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            loading.heightAnchor.constraint(equalToConstant: 100),
            loading.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupLoadingViewConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: searchInput.bottomAnchor, constant: 24),
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            loadingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupEmptyViewConstraints() {
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: searchInput.bottomAnchor, constant: 24),
            emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            emptyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 48),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupSubtitleLabelConstraints() {
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupSearchInputConstraints() {
        NSLayoutConstraint.activate([
            searchInput.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            searchInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            searchInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            searchInput.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupWineGridConstraints() {
        NSLayoutConstraint.activate([
            wineGrid.topAnchor.constraint(equalTo: searchInput.bottomAnchor, constant: 24),
            wineGrid.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            wineGrid.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            wineGrid.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapSearchButton() {
        guard let food = searchInput.text else { return }
        searchInput.resignFirstResponder()
        presenter.getWine(for: food)
        searchInput.text = ""
    }
    
    @objc private func dismissKeyboardWhenCLick() {
        self.view.endEditing(true)
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return wineItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WineCardTableViewCell.identifier, for: indexPath) as? WineCardTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configureWineCard(with: WineCardContent(imageURL: wineItems[indexPath.row].imageURL, name: wineItems[indexPath.row].name))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = wines[indexPath.row]
        presenter.didSelectWine(with: content, alternativeDescriptionText: self.alternativeDescriptionText)
    }
}

extension HomePageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didTapSearchButton()
        return true
    }
}
