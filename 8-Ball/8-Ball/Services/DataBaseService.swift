//
//  RealmService.swift
//  8-Ball
//
//  Created by Никита Хламов on 26.11.2021.
//

import Foundation
import RealmSwift

class DataBaseService {

    func addAnswer(answer: String) {
//        let answerRef = ThreadSafeReference(to: answers)
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let answers = ManagedAnswer()
        do {
            let realm = try Realm()
//            guard let answers = realm.resolve(answerRef) else {
//                return
//            }
            answers.name = answer
            answers.date = Date()
            try realm.write {
                realm.add(answers)
                realm.refresh()
            }
        } catch {
            print("Error")
        }
            }
        }
    }
    func getAnswers() -> [ManagedAnswer] {
        do {
            let realm = try Realm()
            let answers = realm.objects(ManagedAnswer.self).sorted(byKeyPath: "date", ascending: false)
            let arrayAnswers = Array(answers)
            return arrayAnswers
        } catch {
            print("Error")
        }
        return []
    }
    func getRandomAnswer() -> String? {
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(ManagedAnswer.self)
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
            let realmObjects = realm.objects(ManagedAnswer.self).sorted(byKeyPath: "date", ascending: false)
            let answer = realmObjects[index]
            try realm.write {
                realm.delete(answer)
            }
        } catch {
            print("Error")
        }
    }
}