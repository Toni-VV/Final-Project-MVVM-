import Foundation

protocol MainViewModelProtocol {
    var cells: [Main] { get }
    var numberOfRows: Int { get }
    func viewModelCell(index: IndexPath) -> MainViewModelCellProtocol
}

class MainViewModel: MainViewModelProtocol {
    
    var cells: [Main] = [Main(titleLabel: "Characters",imageName: "Characters"),
                         Main(titleLabel: "Episodes", imageName: "Episodes"),
                         Main(titleLabel: "Locations", imageName: "Locations")]
    
    var numberOfRows: Int {
        cells.count
    }
    
    func viewModelCell(index: IndexPath) -> MainViewModelCellProtocol {
        let mainCell = cells[index.row]
        return MainViewModelCell(cell: mainCell)
    }
}
