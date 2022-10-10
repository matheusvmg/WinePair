//
//  DetailsPageViewController.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import UIKit

protocol DetailsPageDelegate: AnyObject {
    func configureDetailsPage(wineDetails: Wine)
}

class DetailsPageViewController: UIViewController, BaseViewProtocol {
    var presenter: DetailsPagePresenterProtocol!
    private var purchaseLink: String?
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Strings.backIcon), for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        button.layer.zPosition = 1
        return button
    }()
    
    private lazy var scrollview: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.isScrollEnabled = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Strings.wineImage)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blue
        label.font = Fonts.Bold.lg
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.black
        label.font = Fonts.Regular.sm
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blue
        label.font = Fonts.Bold.sm
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blue
        label.font = Fonts.Bold.sm
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var link: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blue
        label.font = Fonts.Regular.sm
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        self.view.backgroundColor = Colors.white
        configureLayout()
        addLinkTapGestureRecognizer()
        presenter.getDetails()
    }
    
    func configureLayout() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        container.addSubview(titleLabel)
        container.addSubview(descriptionLabel)
        container.addSubview(priceLabel)
        container.addSubview(scoreLabel)
        scrollview.addSubview(container)
        self.view.addSubview(backButton)
        self.view.addSubview(image)
        self.view.addSubview(scrollview)
    }
    
    func setupConstraints() {
        setupScrollviewConstraints()
        setupContainerConstraints()
        setupBackButtonConstraints()
        setupImageConstraints()
        setupTitleLabelConstraints()
        setupDescriptionLabelConstraints()
        setupPriceLabelConstraints()
        setupScoreLabelConstraints()
    }
    
    private func configureLink() {
        if let purchaseLink = purchaseLink, !purchaseLink.isEmpty {
            container.addSubview(link)
            setupLinkConstraints()
            link.attributedText = NSAttributedString(string: Strings.linkTitle, attributes: [NSAttributedString.Key.underlineColor : Colors.blue, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.thick.rawValue])
        }
    }
    
    private func setupBackButtonConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupImageConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.view.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func setupScrollviewConstraints() {
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 24),
            scrollview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupContainerConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollview.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            container.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
            container.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupPriceLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            priceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupScoreLabelConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            scoreLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            scoreLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupLinkConstraints() {
        NSLayoutConstraint.activate([
            link.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 8),
            link.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            link.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
    
    private func addLinkTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapLink(_:)))
        tap.numberOfTapsRequired = 1
        link.isUserInteractionEnabled = true
        link.addGestureRecognizer(tap)
    }
    
    @objc private func didTapLink(_ sender: UITapGestureRecognizer) {
        guard let link = purchaseLink else { return }
        presenter.goToWebView(link: link)
    }
    
    @objc private func goBack() {
        presenter.goBack()
    }
}

extension DetailsPageViewController: DetailsPageDelegate {
    func configureDetailsPage(wineDetails: Wine) {
        titleLabel.text = presenter.getTitleLabelValue()
        descriptionLabel.text = presenter.getDescriptionLabelValue()
        priceLabel.text = presenter.getPriceLabelValue()
        scoreLabel.text = presenter.getScoreLabelValue()
        purchaseLink = presenter.getPurchaseLinkValue()
        configureLink()
    }
}
