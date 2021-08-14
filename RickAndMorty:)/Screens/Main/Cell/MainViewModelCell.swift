import Foundation

struct Main {
    let titleLabel: String
    let imageName: String
}

protocol MainViewModelCellProtocol {
    var image: String { get }
    var title: String { get }
    init(cell: Main)
}

final class MainViewModelCell: MainViewModelCellProtocol {
   
   private let cell: Main
    
    var title: String {
        cell.titleLabel
    }
    
    var image: String {
        cell.imageName
    }

    required init(cell: Main) {
        self.cell = cell
    }
}


