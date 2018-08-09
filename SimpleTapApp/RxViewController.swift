import UIKit
import RxSwift
import RxCocoa

class RxViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countUpButton: UIButton!
    @IBOutlet weak var countDownButton: UIButton!
    @IBOutlet weak var countResetButton: UIButton!

    private let disposeBag = DisposeBag()

    let viewModel = RxViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupViewModel()
    }

    private func setupViewController() {
        countUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.incrementCount()
            })
            .disposed(by: disposeBag)

        countDownButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.decrementCount()
            })
            .disposed(by: disposeBag)

        countResetButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.resetCount()
            })
            .disposed(by: disposeBag)
    }

    private func setupViewModel() {
        viewModel.countRelay
            .map { return "Rxパターン: \($0)"}
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }

}

class RxViewModel {
    let countRelay = BehaviorRelay<Int>(value: 0)

    func incrementCount() {
        let count = countRelay.value
        countRelay.accept(count + 1)
    }

    func decrementCount() {
        let count = countRelay.value
        countRelay.accept(count - 1)
    }

    func resetCount() {
        countRelay.accept(0)
    }

}
