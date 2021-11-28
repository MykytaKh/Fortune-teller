//
//  RealmService.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation
import RealmSwift

class DataBaseService: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()

    var answers: Results<DataBaseService>!

    func addAnswer(answer: String) {
        let answers = DataBaseService()
        answers.name = answer
        answers.date = Date()
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(answers)
            }
        } catch {
            print("Error")
        }
    }
    func getAnswers() -> [DataBaseService] {
        do {
            let realm = try Realm()
            let answers = realm.objects(DataBaseService.self).sorted(byKeyPath: "date", ascending: false)
            let arrayAnswers = Array(answers)
            return arrayAnswers
        } catch {
            print("Error")
        }
        let arrayAnswers = Array(answers)
        return arrayAnswers
    }
    func getRandomAnswer() -> String? {
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(DataBaseService.self)
            let randomObject = realmObjects.randomElement()
            let randomObjectName = randomObject?.name
            return randomObjectName
        } catch {
            print(L10n.Realm.error)
            return nil
        }
    }
    func deleteAnswer(index: Int) {
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(DataBaseService.self)
            let answer = realmObjects[index]
            try realm.write {
                realm.delete(answer)
            }
        } catch {
            print("Error")
        }
    }
}
