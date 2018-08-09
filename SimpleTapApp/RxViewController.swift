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
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.incrementCount()
            })
            .disposed(by: disposeBag)

        countDownButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.decrementCount()
            })
            .disposed(by: disposeBag)

        countResetButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.resetCount()
            })
            .disposed(by: disposeBag)
    }

    private func setupViewModel() {
        viewModel.countRelay
            .asDriver()
            .map { return "Rxパターン: \($0)"}
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }

}

class RxViewModel {
    let initialCount = 0
    let countRelay = BehaviorRelay<Int>(value: 0)

    init() {
        resetCount()
    }

    func incrementCount() {
        let count = countRelay.value + 1
        countRelay.accept(count)
    }

    func decrementCount() {
        let count = countRelay.value - 1
        countRelay.accept(count)
    }

    func resetCount() {
        countRelay.accept(initialCount)
    }

}
