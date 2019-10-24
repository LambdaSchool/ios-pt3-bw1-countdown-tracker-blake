//
//  CountdownController.swift
//  Dodo
//
//  Created by Blake Andrew Price on 10/21/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import Foundation

class CountdownController: Codable {
    //MARK: - Properties
    var countdowns: [Countdown] = []
    
    //MARK: - Computed Properties
    var finishedCountdowns: [Countdown] {
        return countdowns.filter { $0.cdHasFinished == true }
    }
    
    var unfinishedCountdowns: [Countdown] {
        return countdowns.filter { $0.cdHasFinished == false }
    }
    
    //MARK: - Persistent
    private var countdownListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            else { return nil }
        
        return documents.appendingPathComponent("countdowns.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = countdownListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(countdowns)
            try data.write(to: url)
        } catch {
            print("Error saving countdowns data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = countdownListURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedCountdowns = try decoder.decode([Countdown].self, from: data)
            countdowns = decodedCountdowns
        } catch  {
            print("Error loading countdowns data: \(error)")
        }
    }
    
    //MARK: - Functions
    @discardableResult
    func createCountdown(title: String, dateAndTime: Date) -> Countdown {
        let countdown = Countdown(title: title, dateAndTime: dateAndTime)
        
        countdowns.append(countdown)
        countdowns.sort()
        saveToPersistentStore()

        return countdown
    }
    
    func deleteCountdown(countdown: Countdown) {
        if let index = countdowns.firstIndex(of: countdown) {
            countdowns.remove(at: index)
        }
        countdowns.sort()
        saveToPersistentStore()
    }
    
    func updateTitleOrDate(title: String, dateAndTime: Date, for countdown: Countdown) {
        let index = countdowns.firstIndex(of: countdown)
        if let unwrappedIndex = index {
            var countdownToUpdate = countdowns[unwrappedIndex]
            countdownToUpdate.title = title
            countdownToUpdate.dateAndTime = dateAndTime
            countdowns[unwrappedIndex] = countdownToUpdate
        }
        countdowns.sort()
        saveToPersistentStore()
    }
}

