@testable import Maskota

final class CatRealmDataSourceMock: CatRealmDataSource {
    var storedContent: [CatWire] = []

    var retriaveAllInvocations = 0
    var saveInvocations = 0
    var deleteInvocations = 0

    func retriaveAll() -> [CatWire] {
        retriaveAllInvocations += 1

        return storedContent
    }

    func save(models: [CatWire]) {
        saveInvocations += 1
        storedContent.append(contentsOf: models)
    }

    func delete(modelWire: CatWire) {
        deleteInvocations += 1
        storedContent = storedContent.filter { modelWire.localID == $0.localID }
    }
}
