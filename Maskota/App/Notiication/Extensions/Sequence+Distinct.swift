extension Sequence {
    func distinct<A: Hashable>(by selector: (Iterator.Element) -> A) -> [Iterator.Element] {
        var set: Set<A> = []
        var list: [Iterator.Element] = []

        forEach { element in
            let key = selector(element)
            if set.insert(key).inserted {
                list.append(element)
            }
        }

        return list
    }
}
