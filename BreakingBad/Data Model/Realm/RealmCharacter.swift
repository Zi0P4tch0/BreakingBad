import Foundation
import RealmSwift

final class RealmCharacter: Object {

    override class func primaryKey() -> String? {
        "id"
    }

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var birthday: Date?
    let occupation = List<String>()
    @objc dynamic var image: String = ""
    @objc dynamic var status: String = ""
    let appearance = List<Int>()
    @objc dynamic var nickname: String = ""
    @objc dynamic var portrayedBy: String = ""
    @objc dynamic var liked: Bool = false

}

// MARK: - From Value Type

extension RealmCharacter {

    convenience init(character: Character) {
        self.init()
        id = character.id
        name = character.name
        birthday = character.birthday
        occupation.append(objectsIn: character.occupation)
        image = character.image.absoluteString
        status = character.status
        appearance.append(objectsIn: character.appearance)
        nickname = character.nickname
        portrayedBy = character.portrayedBy
        liked = character.liked
    }

}

// MARK: - To Value Type

extension RealmCharacter {

    func toValue() -> Character {
        Character(id: id,
                  name: name,
                  birthday: birthday,
                  occupation: Array(occupation),
                  // swiftlint:disable:next force_unwrapping
                  image: URL(string: image)!,
                  status: status,
                  appearance: Array(appearance),
                  nickname: nickname,
                  portrayedBy: portrayedBy,
                  liked: liked)
    }

}
