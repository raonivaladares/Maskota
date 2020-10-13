@testable import Maskota

final class CatRealmDataSourceMock: CatRealmDataSource {
    var retriaveAllInvocations = 0
    var saveInvocations = 0
    var deleteInvocations = 0

    func retriaveAll() -> [CatWire] {
        retriaveAllInvocations += 1
        return []
    }

    func save(models: [CatWire]) {
        saveInvocations += 1
    }

    func delete(modelWire: CatWire) {
        deleteInvocations += 1
    }
}
