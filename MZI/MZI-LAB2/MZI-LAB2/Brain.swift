//
//  Brain.swift
//  MZI-LAB2
//
//  Created by Artyom on 3.10.23.
//

import Foundation

class Brain{
    
    private var fileName = ""
    
    public var initialData = ""
    public var initialDataAsBytesArray = [UInt8]()
    
    private let key = "1_2_3_4_5_6_7_8_9_0_1_2_3_4_5_6_" // 32 bytes == 256 bit
    private let syncMessage = "syncMessage12345" // 16 bytes = 128 bit
    
    private var keyAsBytesArray = [UInt8]()
    private var syncMessageAsBytesArray = [UInt8]()
    
    public var finalResult = ""
    
    private let H: [[UInt8]] = [[0xB1, 0x94, 0xBA, 0xC8, 0x0A, 0x08, 0xF5, 0x3B, 0x36, 0x6D, 0x00, 0x8E, 0x58, 0x4A, 0x5D, 0xE4],
                                [0x85, 0x04, 0xFA, 0x9D, 0x1B, 0xB6, 0xC7, 0xAC, 0x25, 0x2E, 0x72, 0xC2, 0x02, 0xFD, 0xCE, 0x0D],
                                [0x5B, 0xE3, 0xD6, 0x12, 0x17, 0xB9, 0x61, 0x81, 0xFE, 0x67, 0x86, 0xAD, 0x71, 0x6B, 0x89, 0x0B],
                                [0x5C, 0xB0, 0xC0, 0xFF, 0x33, 0xC3, 0x56, 0xB8, 0x35, 0xC4, 0x05, 0xAE, 0xD8, 0xE0, 0x7F, 0x99],
                                [0xE1, 0x2B, 0xDC, 0x1A, 0xE2, 0x82, 0x57, 0xEC, 0x70, 0x3F, 0xCC, 0xF0, 0x95, 0xEE, 0x8D, 0xF1],
                                [0xC1, 0xAB, 0x76, 0x38, 0x9F, 0xE6, 0x78, 0xCA, 0xF7, 0xC6, 0xF8, 0x60, 0xD5, 0xBB, 0x9C, 0x4F],
                                [0xF3, 0x3C, 0x65, 0x7B, 0x63, 0x7C, 0x30, 0x6A, 0xDD, 0x4E, 0xA7, 0x79, 0x9E, 0xB2, 0x3D, 0x31],
                                [0x3E, 0x98, 0xB5, 0x6E, 0x27, 0xD3, 0xBC, 0xCF, 0x59, 0x1E, 0x18, 0x1F, 0x4C, 0x5A, 0xB7, 0x93],
                                [0xE9, 0xDE, 0xE7, 0x2C, 0x8F, 0x0C, 0x0F, 0xA6, 0x2D, 0xDB, 0x49, 0xF4, 0x6F, 0x73, 0x96, 0x47],
                                [0x06, 0x07, 0x53, 0x16, 0xED, 0x24, 0x7A, 0x37, 0x39, 0xCB, 0xA3, 0x83, 0x03, 0xA9, 0x8B, 0xF6],
                                [0x92, 0xBD, 0x9B, 0x1C, 0xE5, 0xD1, 0x41, 0x01, 0x54, 0x45, 0xFB, 0xC9, 0x5E, 0x4D, 0x0E, 0xF2],
                                [0x68, 0x20, 0x80, 0xAA, 0x22, 0x7D, 0x64, 0x2F, 0x26, 0x87, 0xF9, 0x34, 0x90, 0x40, 0x55, 0x11],
                                [0xBE, 0x32, 0x97, 0x13, 0x43, 0xFC, 0x9A, 0x48, 0xA0, 0x2A, 0x88, 0x5F, 0x19, 0x4B, 0x09, 0xA1],
                                [0x7E, 0xCD, 0xA4, 0xD0, 0x15, 0x44, 0xAF, 0x8C, 0xA5, 0x84, 0x50, 0xBF, 0x66, 0xD2, 0xE8, 0x8A],
                                [0xA2, 0xD7, 0x46, 0x52, 0x42, 0xA8, 0xDF, 0xB3, 0x69, 0x74, 0xC5, 0x51, 0xEB, 0x23, 0x29, 0x21],
                                [0xD4, 0xEF, 0xD9, 0xB4, 0x3A, 0x62, 0x28, 0x75, 0x91, 0x14, 0x10, 0xEA, 0x77, 0x6C, 0xDA, 0x1D]]
    
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
    
    public func blockCoupling(bytes: [UInt8]) -> [UInt8]{
        
        keyAsBytesArray = [UInt8](key.utf8)
        syncMessageAsBytesArray = [UInt8](syncMessage.utf8)
        
        var Y = syncMessageAsBytesArray
        var result = [UInt8]()
        
        if(bytes.count % 16 == 0){
            let countOfBlocks = bytes.count / 16
            
            for index in 0...countOfBlocks - 1{
                let startPos = index * 16
                let XBytes = Array(bytes[startPos...(startPos + 16) - 1])
                Y = encrypt(bytes: XOR(lhs: XBytes, rhs: Y), key: keyAsBytesArray)
                result.append(contentsOf: Y)
            }
            
        }else{
            let countOfBlocks = bytes.count / 16
            
            for index in 0...countOfBlocks - 1{
                let startPos = index * 16
                let XBytes = Array(bytes[startPos...(startPos + 16)])
                Y = encrypt(bytes: XOR(lhs: XBytes, rhs: Y), key: keyAsBytesArray)
                result.append(contentsOf: Y)
            }
            
            let tmpStartPos = (countOfBlocks - 1) * 16
            let tmpStartPos2 = (countOfBlocks - 2) * 16
            
            let Xn_1 = Array(bytes[tmpStartPos...tmpStartPos + 16])
            let Yn_2 = result.count == 0 ? Y : Array(result[tmpStartPos2...tmpStartPos2 + 16])
            let Ynr = encrypt(bytes: XOR(lhs: Xn_1, rhs: Yn_2), key: keyAsBytesArray)
            let Yn = Array(bytes[0...(bytes.count % 16)])
            let r = Array(Ynr[(bytes.count % 16)...(16 - bytes.count % 16)])
            let Xn = Array(bytes[(countOfBlocks * 16)...(bytes.count % 16)])
            let Yn_1 = encrypt(bytes: XOR(lhs: Xn, rhs: Yn) + r, key: keyAsBytesArray)
            
            result.append(contentsOf: Yn_1)
            result.append(contentsOf: Yn)
            
        }
        
        return result
        
    }
    
    public func blockCouplingDecrypt(bytes: [UInt8]) -> [UInt8]{
        var X = syncMessageAsBytesArray
        var result = [UInt8]()
        
        if(bytes.count % 16 == 0){
            let countOfBlocks = bytes.count / 16
            
            for index in 0...countOfBlocks - 1{
                let startPos = index * 16
                
                let Xi = Array(bytes[startPos...(startPos + 16) - 1])
                var Xi_1 = X
                
                if(index != 0){
                    Xi_1 = Array(bytes[((index - 1) * 16)...((index - 1) * 16) + 16])
                }
                let Y = XOR(lhs: decrypt(bytes: Xi, key: keyAsBytesArray), rhs: Xi_1)
                result.append(contentsOf: Y)
            }
        }else{
            let countOfBlocks = bytes.count / 16
            
            for index in 0...countOfBlocks - 2{
                let startPos = index * 16
                
                let Xi = Array(bytes[startPos...startPos + 16])
                var Xi_1 = X
                
                if(index != 0){
                    Xi_1 = Array(bytes[(startPos - 1)...((startPos - 1) * 16)])
                }
                let Y = XOR(lhs: decrypt(bytes: Xi, key: keyAsBytesArray), rhs: Xi_1)
                result.append(contentsOf: Y)
                
            }
            let tmpStartPos = (countOfBlocks - 1) * 16
            let tmpStartPos2 = (countOfBlocks - 2) * 16
            
            let Xn_1 = Array(bytes[tmpStartPos...tmpStartPos + 16])
            var Xn = Array(bytes[(countOfBlocks * 16)...(bytes.count % 16)])
            
            for _ in 0...(16 - bytes.count % 16){
                Xn.append(UInt8(0))
            }
            
            let Ynr = XOR(lhs: decrypt(bytes: Xn_1, key: keyAsBytesArray), rhs: Xn)
            let Yn = Array(Ynr[0...(bytes.count % 16)])
            var r = Array(Ynr[(bytes.count % 16)...(16 - bytes.count % 16)])
            var Xn_2 = Array(bytes[tmpStartPos2...tmpStartPos2 + 16])
            
            if(countOfBlocks == 1){
                Xn_2 = X
            }
            
            for index in 0...(r.count - 1){
                Xn.append(r[index])
            }
            
            let Yn_1 = XOR(lhs: decrypt(bytes: Xn, key: keyAsBytesArray), rhs: Xn_2)
            
            result.append(contentsOf: Yn_1)
            result.append(contentsOf: Yn)
            
        }
        
        return result

    }
    
    private func XOR(lhs: [UInt8], rhs: [UInt8]) -> [UInt8]{
        var result = [UInt8]()
        
        var rhsToWork = rhs
        
        if(rhsToWork.count < lhs.count){
            rhsToWork.append(0)
        }
        
        for index in 0...lhs.count - 1{
            result.append(lhs[index] ^ rhsToWork[index])
        }
        return result
    }
    
    private func decrypt(bytes: [UInt8], key: [UInt8]) -> [UInt8]{
        var aBytes = Array(bytes[0...3])
        var bBytes = Array(bytes[4...7])
        var cBytes = Array(bytes[8...11])
        var dBytes = Array(bytes[12...15])
        
        var a = aBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        var b = bBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        var c = cBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        var d = dBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        
        for index in (0...7).reversed(){
            b = b ^ Gr(word: plusByModule(lhs: a, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1))), r: 5)
            c = c ^ Gr(word: plusByModule(lhs: d, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 1)), r: 21)
            a = minusByModule(lhs: a, rhs: Gr(word: plusByModule(lhs: b, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 2)), r: 13))
            let e = Gr(word: plusByModule(lhs: plusByModule(lhs: b, rhs: c), rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 3)), r: 21) ^ UInt32(index + 1)
            b = plusByModule(lhs: b, rhs: e)
            c = minusByModule(lhs: c, rhs: e)
            d = plusByModule(lhs: d, rhs: Gr(word: plusByModule(lhs: c, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 4)), r: 13))
            b = b ^ Gr(word: plusByModule(lhs: a, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 5)), r: 21)
            c = c ^ Gr(word: plusByModule(lhs: d, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 6)), r: 5)
            (a, b) = (b, a)
            (c, d) = (d, c)
            (a, d) = (d, a)
        }
        aBytes = withUnsafeBytes(of: a.littleEndian, Array.init)
        bBytes = withUnsafeBytes(of: b.littleEndian, Array.init)
        cBytes = withUnsafeBytes(of: c.littleEndian, Array.init)
        dBytes = withUnsafeBytes(of: d.littleEndian, Array.init)
        
        return cBytes + aBytes + dBytes + bBytes
        
    }
    
    private func encrypt(bytes: [UInt8], key: [UInt8]) -> [UInt8]{
        var aBytes = Array(bytes[0...3])
        var bBytes = Array(bytes[4...7])
        var cBytes = Array(bytes[8...11])
        var dBytes = Array(bytes[12...15])
        
        var a = aBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        var b = bBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        var c = cBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        var d = dBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
        
        for index in 0...7{
            b = b ^ Gr(word: plusByModule(lhs: a, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 6)), r: 5)
            c = c ^ Gr(word: plusByModule(lhs: d, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 5)), r: 21)
            a = minusByModule(lhs: a, rhs: Gr(word: plusByModule(lhs: b, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 4)), r: 13))
            let e = Gr(word: plusByModule(lhs: plusByModule(lhs: b, rhs: c), rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 3)), r: 21) ^ UInt32(index + 1)
            b = plusByModule(lhs: b, rhs: e)
            c = minusByModule(lhs: c, rhs: e)
            d = plusByModule(lhs: d, rhs: Gr(word: plusByModule(lhs: c, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 2)), r: 13))
            b = b ^ Gr(word: plusByModule(lhs: a, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1) - 1)), r: 21)
            c = c ^ Gr(word: plusByModule(lhs: d, rhs: getKeyPart(key: key, partOfKey: 7 * (index + 1))), r: 5)
            (a, b) = (b, a)
            (c, d) = (d, c)
            (b, c) = (c, b)
        }
        aBytes = withUnsafeBytes(of: a.littleEndian, Array.init)
        bBytes = withUnsafeBytes(of: b.littleEndian, Array.init)
        cBytes = withUnsafeBytes(of: c.littleEndian, Array.init)
        dBytes = withUnsafeBytes(of: d.littleEndian, Array.init)
        
        return bBytes + dBytes + aBytes + cBytes
        
    }
    
    private func getKeyPart(key: [UInt8], partOfKey: Int) -> UInt32{
        var partOfKeyToWork = partOfKey
        
        if(partOfKeyToWork % 8 == 0){
            partOfKeyToWork = 8
        }else{
            partOfKeyToWork = partOfKeyToWork % 8
        }
        let startPos = (partOfKeyToWork - 1) * 4
        
        let subKey = key[(startPos)...(startPos + 4) - 1]
        
        return Array(subKey).withUnsafeBytes { $0.load(as: UInt32.self) }
    }
    
    private func plusByModule(lhs: UInt32, rhs: UInt32) -> UInt32{
        
        return (lhs &+ rhs) % UInt32.max
    }
    
    private func minusByModule(lhs: UInt32, rhs: UInt32) -> UInt32{
        
        return (lhs &- rhs) % UInt32.max
    }
    
    private func Gr(word: UInt32, r: UInt32) -> UInt32{
        var wordToWork = word
        
        wordToWork = HChange(word: wordToWork);
        wordToWork = (wordToWork << r) | (wordToWork >> (32 - r))
        
        return wordToWork
    }
    
    private func HChange(word: UInt32) -> UInt32{
        var wordAsBytes = withUnsafeBytes(of: word.littleEndian, Array.init)
        
        for index in 0...3{
            let b = UInt32(wordAsBytes[index])
            let left = (b >> 4)
            let right = (b << 28) >> 28;
            
            wordAsBytes[index] = H[Int(left)][Int(right)]
            
        }
        return wordAsBytes.withUnsafeBytes { $0.load(as: UInt32.self) }
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
