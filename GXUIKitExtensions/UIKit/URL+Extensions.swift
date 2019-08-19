//
//  URL+Extensions.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 3/5/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import Foundation
/*
public enum GixDirectoryType:String {
    case LanguagePack = "LanguagePack"
}
*/
public extension URL {
    var fileSize:Int{
        do {
            let resources = try self.resourceValues(forKeys:[.fileSizeKey])
            return resources.fileSize ?? -1
        } catch {
            print("Error: \(error)")
        }
        return -1
    }
    /*
    static func getDirectory(for type:GixDirectoryType) -> URL?{
        switch type {
        case .LanguagePack:
            return URL.cacheDirectory?.appendingPathComponent(GixDirectoryType.LanguagePack.rawValue)
        }
    }
    
    
    static func getURL(for fileName:String, type:GixDirectoryType, intermediateDirectory:String? = nil, isExcludedFromBackup:Bool = false) -> URL?{
        guard let directoryUrl:URL = self.getDirectory(for: type),
            let preparedDirectoryUrl:URL = self.prepareDirectory(directoryUrl, isExcludedFromBackup)
            else { return nil }
        let m_fileName = fileName as NSString
        
        if let intermediateDirectory = intermediateDirectory {
            return preparedDirectoryUrl.appendingPathComponent(intermediateDirectory).appendingPathComponent(m_fileName.lastPathComponent)
        }
        return preparedDirectoryUrl.appendingPathComponent(m_fileName.lastPathComponent)
    }
    */
    
    @discardableResult
    static func prepareDirectory(_ url:URL, _ isExcludedFromBackup:Bool = true) -> URL?{
        var url:URL = url
        var isDirectory:ObjCBool = false
        if FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) {
            if (isDirectory).boolValue { return url; }
            do{ try FileManager.default.removeItem(at: url)
            }catch{ LOGW("Unable to remove incorrect DIR: \(error)"); return nil; }
        }
        
        do{
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: [FileAttributeKey.protectionKey :FileProtectionType.none])
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = isExcludedFromBackup
            //Exclude Databse file from being backed up
            try url.setResourceValues(resourceValues)
        }catch{
            LOGE("Failed to set file data for Url:\(url.path). Error:\(error)")
            return nil
        }
        return url
    }
    
    
    func deleteFile() throws -> Void{ try FileManager.default.removeItem(at: self); }
    
    var fileExitOnDisk:Bool{ return FileManager.default.fileExists(atPath: self.path); }

    static var rootDirectory:URL?{
        return URL.documentDirectory?.deletingLastPathComponent()
    }
    
    static var documentDirectory:URL?{
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
    }
    static var libraryDirectory:URL?{
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.libraryDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
    }
    static var cacheDirectory:URL?{
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
    }
    static var tempDirectoryUrl:URL?{
        return FileManager.default.temporaryDirectory
    }
    
    func downloadFile(_ urlOnDisk:URL, completion: @escaping (_ succeeded:Bool, _ error:Error?) -> Void){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:self)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    if urlOnDisk.fileExitOnDisk {
                        try FileManager.default.removeItem(at: urlOnDisk)
                    }
                    //try FileManager.default.copyItem(at: tempLocalUrl, to: urlOnDisk)
                    try FileManager.default.moveItem(at: tempLocalUrl, to: urlOnDisk)
                    completion(urlOnDisk.fileExitOnDisk, nil)
                } catch (let writeError) {
                    print("Error creating a file \(urlOnDisk) : \(writeError)")
                    completion(false, writeError)
                }
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "");
                completion(false, error)
            }
        }
        task.resume()
    }
    
    var creationDate:Date? {
        do{
            let attrs = try FileManager.default.attributesOfItem(atPath: self.path)
            return attrs[FileAttributeKey.creationDate] as? Date
        }catch{
            LOGE("Unable to get attribute for path:\(self.path)")
        }
        return nil
    }
}
