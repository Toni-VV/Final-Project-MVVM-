import UIKit

protocol MainViewModelProtocol {
    var cells: [Main] { get }
    var numberOfRows: Int { get }
    func viewModelCell(index: IndexPath) -> MainViewModelCellProtocol
}

final class MainViewModel: MainViewModelProtocol {
    
    var cells: [Main] = [Main(commonLabel: "Characters"),
                         Main(commonLabel: "Episodes"),
                         Main(commonLabel: "Locations")]
    
    var numberOfRows: Int {
        cells.count
    }
    
    func viewModelCell(index: IndexPath) -> MainViewModelCellProtocol {
        let mainCell = cells[index.row]
        return MainViewModelCell(cell: mainCell)
    }
}
