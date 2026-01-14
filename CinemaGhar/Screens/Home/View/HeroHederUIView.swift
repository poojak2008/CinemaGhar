//
//  HeroHederUIView.swift
//  CinemaGhar
//
//  Created by pooja kamble on 10/12/25.
//

import UIKit

class HeroHederUIView: UIView {

    private var titles: [Titles] = []
    private var timer: Timer?
    private var currentIndex = 0
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.cornerRadius = 6
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.cornerRadius = 6
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(collectionView)
        collectionView.frame = bounds

        collectionView.register(
            HeroPosterCollectionViewCell.self,
            forCellWithReuseIdentifier: HeroPosterCollectionViewCell.identifier
        )

        collectionView.dataSource = self
        collectionView.delegate = self
        addButtons()
        updateButtonBorderColors()
    }

    private func addButtons() {
        let stack = UIStackView(arrangedSubviews: [playButton, downloadButton])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            stack.widthAnchor.constraint(equalToConstant: 260),
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func updateButtonBorderColors() {
        let color = UIColor.label.cgColor
        playButton.layer.borderColor = color
        downloadButton.layer.borderColor = color
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        collectionView.collectionViewLayout.invalidateLayout()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateButtonBorderColors()
        }
    }


    // 🔥 Configure with API data
    func configure(with titles: [Titles]) {
        self.titles = titles
        collectionView.reloadData()
        startAutoScroll()
    }

    private func startAutoScroll() {
        timer?.invalidate()

        timer = Timer.scheduledTimer(
            timeInterval: 6,
            target: self,
            selector: #selector(autoScroll),
            userInfo: nil,
            repeats: true
        )
    }

    @objc private func autoScroll() {
        guard titles.count > 1 else { return }

        currentIndex += 1

        if currentIndex >= titles.count {
            currentIndex = 0
            collectionView.scrollToItem(
                at: IndexPath(item: 0, section: 0),
                at: .left,
                animated: false
            )
        } else {
            collectionView.scrollToItem(
                at: IndexPath(item: currentIndex, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startAutoScroll()
    }

}

extension HeroHederUIView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HeroPosterCollectionViewCell.identifier,
            for: indexPath
        ) as? HeroPosterCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let poster = titles[indexPath.item].poster_path {
            cell.configure(with: poster)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize( width: collectionView.bounds.width,
                       height: collectionView.bounds.height)
    }
    
}
