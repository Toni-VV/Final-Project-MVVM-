import Foundation

struct Main {
    let commonLabel: String
}

protocol MainViewModelCellProtocol {
    var commonString: String { get }
    init(cell: Main)
}

final class MainViewModelCell: MainViewModelCellProtocol {
    
    var commonString: String {
         (cell.commonLabel)
    }

    private let cell: Main
    
    required init(cell: Main) {
        self.cell = cell
    }
}


