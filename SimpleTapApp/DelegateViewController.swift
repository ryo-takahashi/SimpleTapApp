import UIKit

class DelegateViewController: UIViewController {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!

    let viewModel = DelegateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    @IBAction func countUp(_ sender: Any) {
        viewModel.incrementCount()
    }
    
    @IBAction func countDown(_ sender: Any) {
        viewModel.decrementCount()
    }

}

extension DelegateViewController: SimpleTapDelegate {
    func updateCount(count: Int) {
        countLabel.text = "Delegateパターン: \(count)"
    }
}

protocol SimpleTapDelegate {
    func updateCount(count: Int)
}

class DelegateViewModel {
    private var count = 0 {
        didSet {
            delegate?.updateCount(count: count)
        }
    }

    var delegate: SimpleTapDelegate?

    func incrementCount() {
        count += 1
    }
    
    func decrementCount() {
        count -= 1
    }
}
