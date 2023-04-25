//
//  TextField.swift
//  
//
//  Created by Anton Tsikhanau on 24.04.23.
//

import UIKit
import RxCocoa

open class TextField: UITextField {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 17, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 6
        clipsToBounds = true
    }
}
