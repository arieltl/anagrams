//
//  ViewController.swift
//  anagramas
//
//  Created by ariel leventhal on 01/03/18.
//  Copyright © 2018 ariel. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var repetitionsTF: NSTextField!
    @IBOutlet weak var nameTF: NSTextField!
   
    @IBOutlet var textView: NSTextView!
    
    
    var anagrams = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func generate(_ sender: Any) {
        anagrams.removeAll()
        
        var anagram = [Character]()
        guard let text = nameTF.accessibilityValue()?.lowercased(), text.count > 0 else {return}
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
            
        }
        textView.textStorage?.append(NSAttributedString(string: anagrams.description))
    }
    
 
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

    
    



