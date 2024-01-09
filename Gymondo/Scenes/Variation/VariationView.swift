//
//  VariationView.swift
//  Gymondo
//
//  Created by Amir Daliri on 8.01.2024.
//

import UIKit

final class VariationView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .fill
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = #colorLiteral(red: 0.9569378495, green: 0.9278458953, blue: 0.9117631316, alpha: 1)
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupNameLabelConstraints()
        setupStackViewConstraints()
    }
    
    private func setupScrollViewConstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupContentViewConstraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
        ])
    }
    
    private func setupNameLabelConstraints() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupStackViewConstraints() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // Method to configure the view with an Exercise object
    func configure(with exercise: Exercise) {
        nameLabel.text = exercise.name

        // Clear existing image views from the stack view
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add new image views for each image in the exercise
        if let images = exercise.images, !images.isEmpty {
            for image in images {
                let imageView = createImageView()
                // Assuming `imageUrl` is a string and using a method to load the image
                imageView.setImage(with: image.image)
                stackView.addArrangedSubview(imageView)
            }
        } else {
            let imageView = createImageView()
            imageView.image = UIImage(named: "placeholder")
            stackView.addArrangedSubview(imageView)
        }
    }

    // Helper method to create an image view
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = false
        imageView.layer.shadowColor = UIColor(red: 0.925, green: 0.655, blue: 0.502, alpha: 1).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 5
        
        applyBorder(to: imageView)
        applyRoundedCorners(to: imageView)
        applyShadow(to: imageView, color: UIColor(red: 0.925, green: 0.655, blue: 0.502, alpha: 1))
        
        return imageView
    }
    
    // Apply a border
    private func applyBorder(to view: UIView, width: CGFloat = 1.0, color: UIColor = .gray) {
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
    }
    
    // Apply rounded corners
    private func applyRoundedCorners(to view: UIImageView, cornerRadius: CGFloat = 10) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }

    // Apply shadow
    private func applyShadow(to view: UIImageView, color: UIColor, opacity: Float = 1, radius: CGFloat = 5, offset: CGSize = CGSize(width: 0, height: 2)) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offset
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}
