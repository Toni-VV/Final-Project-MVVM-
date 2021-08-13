import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: Listener?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(completion: @escaping Listener) {
        self.listener = completion
        listener?(value)
    }
}

