//
//  ViewController.swift
//  
//
//  Created by Anton Tsikhanau on 24.04.23.
//

import UIKit
import RxSwift
import RxCocoa

open class ViewController: UIViewController {
    public let disposeBag = DisposeBag()
}

public extension ViewController {
    @discardableResult
    func showAlert(title: String?, message: String?, actionTitle: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)// { _ in alert.dismiss(animated: true) }
        alert.addAction(action)
        present(alert, animated: true)
        return alert
    }

    func showError(_ error: Error) {
        showAlert(
            title: R.string.localizable.error(),
            message: error.localizedDescription,
            actionTitle: R.string.localizable.ok()
        )
    }
}
