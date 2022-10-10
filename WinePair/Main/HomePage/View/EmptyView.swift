//
//  EmptyView.swift
//  WinePair
//
//  Created by Matheus Góes on 02/10/22.
//

import UIKit

final class EmptyView: UIView, BaseViewProtocol {
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Strings.wineIconName)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.black
        label.text = Strings.emptyViewTitle
        label.font = Fonts.Medium.sm
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.black
        label.text = Strings.emptyViewDescription
        label.font = Fonts.Regular.xs
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        self.addSubview(image)
        self.addSubview(titleLabel)
        self.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        setupImageConstraints()
        setupTitleLabelConstraints()
        setupNameLabelConstraints()
    }
    
    private func setupImageConstraints() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            image.heightAnchor.constraint(equalToConstant: 90),
            image.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 64),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -64)
        ])
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -80)
        ])
    }
}
