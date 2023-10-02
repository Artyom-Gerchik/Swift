//
//  Brain.swift
//  MZI-LAB1
//
//  Created by Artyom on 7.09.23.
//

import Foundation

class Brain{
    
    private var fileName = ""
    
    public var initialData = ""
    public var initialDataAsBytesArray = [UInt8]()
    
    private let key = "1_2_3_4_5_6_7_8_9_0_1_2_3_4_5_6_" // 32 bytes == 256 bit
    private let gamma = "gamma123" // 8 bytes = 64 bit
    
    private var keyAsBytesArray = [UInt8]()
    private var gammaAsBytesArray = [UInt8]()
    
    public var finalResult = ""
    
    private let SBlock: [[UInt8]] = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
                                     [15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                                     [14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
                                     [13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                                     [12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
                                     [11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                                     [10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                                     [9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8]]
    
    public func getData(){
        
        print("Enter name of file to read from desktop: ", terminator: "")
        fileName = readLine()!
        
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileName).appendingPathExtension("txt")
            
            do {
                initialData = try String(contentsOf: fileURL, encoding: .utf8)
                initialDataAsBytesArray = [UInt8](initialData.utf8)
                
                print("")
                print("INITIAL")
                print(initialData, terminator: " = ")
                print(initialDataAsBytesArray)
                print("INITIAL")
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func saveData(){
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent("outputForMZI1").appendingPathExtension("txt")
            
            do {
                try finalResult.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
    }
        
        private func getKeyPart(key: [UInt8], indexOfKey: Int) -> UInt32{
            let startIndex = (indexOfKey - 1) * 4
            let endIndex = startIndex + 4
            let subKey = key[(startIndex)...(endIndex - 1)]
            
            return Array(subKey).withUnsafeBytes { $0.load(as: UInt32.self) }
        }
        
        private func change(block: UInt32) -> UInt32{
            
            var blockAsBytes = withUnsafeBytes(of: block.littleEndian, Array.init)
            
            var jindex = 0
            for index in 0...3 {
                let blockAsInt = UInt32(blockAsBytes[index])
                let leftPart = blockAsInt >> 4
                let rightPart = (blockAsInt << 28) >> 28
                
                let leftPartUInt8 = SBlock[(jindex)][Int(leftPart)]
                jindex += 1
                let rightPartUInt8 = SBlock[(jindex)][Int(rightPart)]
                jindex += 1
                
                blockAsBytes[index] = UInt8((leftPartUInt8 << 4)|(rightPartUInt8))
            }
            return blockAsBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        }
        
        private func easyChangeMode(bytes: [UInt8], key: [UInt8], encrypting: Bool) -> [UInt8]{
            
            let splittedBytes = bytes.split()
            
            let leftBytes = splittedBytes.left
            let rightBytes = splittedBytes.right
            
            var leftBytesAsInt = leftBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
            var rightBytesAsInt = rightBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
            
            var keyIndex = 0
            
            for index in 0...31 {
                if(encrypting){
                    if(index < 24){
                        keyIndex = index % 8
                    }else{
                        keyIndex =  7 - (index % 8)
                    }
                }else{
                    if(index < 8){
                        keyIndex = index % 8
                    }else{
                        keyIndex =  7 - (index % 8)
                    }
                }
                
                var result : UInt32
                result = (UInt32(leftBytesAsInt) ^ UInt32(getKeyPart(key: key, indexOfKey: keyIndex + 1))) % UInt32.max
                
                result = UInt32(change(block: result))
                result = (result << 11) | (result >> 21)
                result ^= rightBytesAsInt
                
                if(index < 31){
                    rightBytesAsInt = leftBytesAsInt
                    leftBytesAsInt = result
                }else{
                    rightBytesAsInt = result
                }
            }
            
            let leftAsBytes = withUnsafeBytes(of: leftBytesAsInt.littleEndian, Array.init)
            let rightAsBytes = withUnsafeBytes(of: rightBytesAsInt.littleEndian, Array.init)
            
            let res = leftAsBytes + rightAsBytes
            
            return res
        }
        
        public func gammificationMode(plainText: [UInt8]?) -> [UInt8]{
            
            keyAsBytesArray = [UInt8](key.utf8)
            gammaAsBytesArray = [UInt8](gamma.utf8)
            let encryptedGamma = easyChangeMode(bytes: gammaAsBytesArray, key: keyAsBytesArray, encrypting: true)
            
            var C2 : UInt32 = 0x1010101;
            var C1 : UInt32 = 0x1010104;
            
            var result = [UInt8]()
            var index = 0
            
            while(true){
                var N3 = encryptedGamma.split().left.withUnsafeBytes { $0.load(as: UInt32.self) }
                var N4 = encryptedGamma.split().right.withUnsafeBytes { $0.load(as: UInt32.self) }
                
                N3 = (N3 + C2) % UInt32.max
                N4 = (N4 + (C1 - 1)) % (UInt32.max - 1) + 1
                
                var N12 = withUnsafeBytes(of: N3.littleEndian, Array.init) + withUnsafeBytes(of: N4.littleEndian, Array.init)
                var encryptedN12 = easyChangeMode(bytes: N12, key: keyAsBytesArray, encrypting: true)
                
                var tmp = encryptedN12.count - 1
                
                for jindex in 0...tmp {
                    if(index < plainText!.count){
                        result.append(encryptedN12[jindex] ^ plainText![index])
                        index += 1
                    }else{
                        break
                    }
                }
                
                if(index >= plainText!.count){
                    break;
                }
            }
            return result
        }
    }
    
    extension Array {
        func split() -> (left: [Element], right: [Element]) {
            let ct = self.count
            let half = ct / 2
            let leftSplit = self[0 ..< half]
            let rightSplit = self[half ..< ct]
            return (left: Array(leftSplit), right: Array(rightSplit))
        }
    }
