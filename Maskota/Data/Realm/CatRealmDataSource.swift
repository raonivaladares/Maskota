import RealmSwift
import Foundation

protocol CatRealmDataSource {
    func retriaveAll() -> [CatWire]
    func save(models: [CatWire])
    func delete(modelWire: CatWire)
}

final class CatRealmDataSourceImp {
    let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    func save(models: [CatWire]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            try? self.realm.write {
                let entities = models.map(CatRealmEntity.init)
                self.realm.add(entities, update: .all)
            }
        }
    }

    func retriaveAll() -> [CatWire] {
        realm
            .objects(CatRealmEntity.self)
            .map(CatWire.init)
    }

    func delete(modelWire: CatWire) {
        let predicate = NSPredicate(format: "id = %@", "\(modelWire.localID)")
        let result = realm
            .objects(CatRealmEntity.self)
            .filter(predicate)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            try? self.realm.write {
                let childs = result.flatMap { $0.feedTimes }
                self.realm.delete(childs)
                self.realm.delete(result)
            }
        }
    }
}
