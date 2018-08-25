import UIKit

class DelegateExmapleViewController: UIViewController {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!

    private let presenter = DelegateExamplePresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
    }

    @IBAction func countUp(_ sender: Any) {
        presenter.incrementCount()
    }

    @IBAction func countDown(_ sender: Any) {
        presenter.decrementCount()
    }

    @IBAction func resetCount(_ sender: Any) {
        presenter.resetCount()
    }

}

extension DelegateExmapleViewController: DelegateExampleView {
    func updateCount(count: Int) {
        countLabel.text = "Delegateパターン: \(count)"
    }
}

protocol DelegateExampleView {
    func updateCount(count: Int)
}


class DelegateExamplePresenter {
    private var count = 0

    private var delegateExampleView: DelegateExampleView?

    func attachView(_ view: DelegateExampleView) {
        self.delegateExampleView = view
    }
    
    func detachView() {
        self.delegateExampleView = nil
    }
    
    func incrementCount() {
        count += 1
        delegateExampleView?.updateCount(count: count)
    }

    func decrementCount() {
        count -= 1
        delegateExampleView?.updateCount(count: count)
    }

    func resetCount() {
        count = 0
        delegateExampleView?.updateCount(count: count)
    }
}
