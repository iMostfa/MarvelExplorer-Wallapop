//
//  ImagePreviewerController.swift
//  MarvelExplorer
//
//  Created by Mostafa Essam on 11/2/23.
//

import UIKit

class ImagePreviewerController: UIViewController {
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  init(image: UIImage) {
    imageView.image = image
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    setupView()
  }
  func setupView() {
    view.addSubview(imageView)
    view.backgroundColor = .systemPurple.withAlphaComponent(0.3)
    imageView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview()
      make.center.equalToSuperview()
    }

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
