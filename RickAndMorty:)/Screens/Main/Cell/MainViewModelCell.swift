import Foundation

struct Main {
    let commonLabel: String
}

protocol MainViewModelCellProtocol {
    var commonString: String { get }
    init(cell: Main)
}

final class MainViewModelCell: MainViewModelCellProtocol {
    
   private let cell: Main
    
    var commonString: String {
         (cell.commonLabel)
    }

    required init(cell: Main) {
        self.cell = cell
    }
}


