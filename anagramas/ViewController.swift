//
//  ViewController.swift
//  anagramas
//
//  Created by ariel leventhal on 01/03/18.
//  Copyright © 2018 ariel. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var letrasRepet: NSTextField!
    @IBOutlet weak var repetitionsTF: NSTextField!
    @IBOutlet weak var nameTF: NSTextField!
    @IBOutlet weak var secondsLabel: NSTextField!
    
    @IBOutlet var tableView: NSTableView!
    
    
    var anagrams = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        secondsLabel.stringValue = ""
    }
    func factorial(factorialNumber: UInt64) -> UInt64 {
    if factorialNumber == 0 {
    return 1
    } else {
        return factorialNumber * factorial(factorialNumber: factorialNumber - 1)
    }
    }


    @IBAction func generate(_ sender: Any) {
        anagrams.removeAll()
        
        var anagram = [Character]()
        guard let text = nameTF.accessibilityValue()?.lowercased(), text.count > 0 else {return}
        let max = factorial(factorialNumber: UInt64(text.count))/factorial(factorialNumber: UInt64(letrasRepet.stringValue) ?? 1)
        let start = Date()
        for _ in 1...Int(repetitionsTF.accessibilityValue()!)! {
            for character in text {
                let randomInt = Int(arc4random_uniform(UInt32(anagram.count + 1)))
                anagram.insert(character, at: randomInt)
            }
            
            if !anagrams.contains(String(anagram)) {
                anagrams.append(String(anagram))
            }
            print(anagram)
            anagram.removeAll()
            
            
            if anagrams.count >= max {
                let end = Date()
                let interval = end.timeIntervalSince(start)
                print(anagrams.count)
                print(interval)
                secondsLabel.stringValue = String(interval)
                tableView.reloadData()
                return
            }
            
        }
        let end = Date()
        let interval = end.timeIntervalSince(start)
        print(anagrams.count)
        print(interval)
        secondsLabel.stringValue = String(interval)
        tableView.reloadData()
    }
    
  
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController : NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return anagrams.count
    }
}
    
extension ViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init("id"), owner: nil) as! NSTableCellView
        cell.textField?.stringValue = anagrams[row]
        return cell
    }
}


