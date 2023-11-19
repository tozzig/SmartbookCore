//
//  ActionButton.swift
//  
//
//  Created by Anton Tsikhanau on 23.04.23.
//

import UIKit

public class ActionButton: UIButton {
    public override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }

    public override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? R.color.main() : R.color.inactive()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
}

private extension ActionButton {
    func configureButton() {
        layer.cornerRadius = 6
        setTitleColor(R.color.buttonText(), for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        backgroundColor = R.color.main()
        setTitleColor(R.color.secondaryText(), for: .disabled)
    }
}
