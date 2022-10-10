//
//  WineCardTableViewCell.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import UIKit

final class WineCardTableViewCell: UITableViewCell, BaseViewProtocol {
    static let identifier = Strings.wineCardTableViewCellIdentifier
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: Strings.wineImage)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.black
        label.text = Strings.cardTitle
        label.font = Fonts.Medium.sm
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.black
        label.font = Fonts.Regular.xs
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.lightGray
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
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 191)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    func configureWineCard(with information: WineCardContent) {
        guard let titleInfo = information.name else { return }
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
        nameLabel.text = titleInfo
    }

}
