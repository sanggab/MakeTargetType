//
//  ContentView + GenerateFile.swift
//  MakeTargetType
//
//  Created by Gab on 2/3/26.
//

import Foundation

extension SettingViewModel {
    func createTargetTypeFile() {
        do {
            let baseProjectURL = try validateProjectURL()
            let targetModel = try validateDisplayName(APITargetDescriptor: self.apiTargetModel)
            try validateCasseName(APITargetDescriptor: self.apiTargetModel)
            
            let targetTypeName = "\(targetModel.displayName)TargetType"
            let fileName = "\(targetTypeName).swift"
            
            // 폴더 생성 없이 바로 경로 설정
            let directoryPath = baseProjectURL.appendingPathComponent(findPath)
            let fileURL = directoryPath.appendingPathComponent(fileName)
            let fileManager = FileManager.default
            
            // 혹시 모르니 기본 경로는 생성 확인
            try createDirectory(directoryPath: directoryPath)
            
            if fileManager.fileExists(atPath: fileURL.path) {
                // 파일이 존재하면 Case 추가
                do {
                    var existingContent = try String(contentsOf: fileURL, encoding: .utf8)
                    let newContent = GenerateTemplate.default.appendTargetTypeCase(fileContent: &existingContent, model: apiTargetModel)
                    try newContent.write(to: fileURL, atomically: true, encoding: .utf8)
                    
                    print("상갑 logEvent \(#function) success appended \(fileURL.path)")
                    self.showAlert("성공", "\(fileName) 파일에 새로운 Case가 추가되었습니다.")
                    self.loadTargetTypeList(from: baseProjectURL)
                    self.successCreateFile()
                } catch {
                    print("상갑 logEvent \(#function) append error \(error)")
                    self.showAlert("에러", "파일 수정 중 오류가 발생했습니다.\n\(error.localizedDescription)")
                }
            } else {
                // 파일이 없으면 새로 생성
                let content = GenerateTemplate.default.makeTargetTypeDefault(APITargetDescriptor: apiTargetModel)
                
                print("상갑 logEvent \(#function) fileURL \(fileURL.path)")
                
                try content.write(to: fileURL, atomically: true, encoding: .utf8)
                print("상갑 logEvent \(#function) success created \(fileURL.path)")
                self.showAlert("성공", "\(fileName) 파일이 생성되었습니다.")
                
                self.loadTargetTypeList(from: baseProjectURL)
                self.successCreateFile()
            }
        } catch {
            switch error {
            case let validateError as ValidateError:
                self.showAlert(validateError.alert)
            default:
                self.showAlert("에러", "파일 생성 중 오류가 발생했습니다.\n\(error.localizedDescription)")
            }
        }
    }
}

extension SettingViewModel {
    func createTargetTypeFileWithFolder() {
        do {
            let baseProjectURL = try validateProjectURL()
            let targetModel = try validateDisplayName(APITargetDescriptor: self.apiTargetModel)
            try validateCasseName(APITargetDescriptor: self.apiTargetModel)
            
            let targetTypeName = "\(targetModel.displayName)TargetType"
            let fileName = "\(targetTypeName).swift"
            // Construct path: projectPath/Core/NetWork/Sources/API/TargetType/displayName
            let directoryPath = baseProjectURL.appendingPathComponent(findPath).appendingPathComponent(targetModel.displayName)
            
            let fileURL = directoryPath.appendingPathComponent(fileName)
            
            let fileManager = FileManager.default
            
            try createDirectory(directoryPath: directoryPath)
            
            if fileManager.fileExists(atPath: fileURL.path) {
                // Append Case Logic
                do {
                    var existingContent = try String(contentsOf: fileURL, encoding: .utf8)
                    let newContent = GenerateTemplate.default.appendTargetTypeCase(fileContent: &existingContent, model: apiTargetModel)
                    try newContent.write(to: fileURL, atomically: true, encoding: .utf8)
                    
                    print("상갑 logEvent \(#function) success appended \(fileURL.path)")
                    self.showAlert("성공", "\(fileName) 파일에 새로운 Case가 추가되었습니다.")
                    self.loadTargetTypeList(from: baseProjectURL)
                    self.successCreateFile()
                } catch {
                    print("상갑 logEvent \(#function) append error \(error)")
                    self.showAlert("에러", "파일 수정 중 오류가 발생했습니다.\n\(error.localizedDescription)")
                }
                return
            } else {
                // Ensure makeTargetTypeDefault returns String. It's in Template.swift (global func inferred).
                let content = GenerateTemplate.default.makeTargetTypeDefault(APITargetDescriptor: apiTargetModel)
                
                print("상갑 logEvent \(#function) filURL \(fileURL.path)")
                
                try content.write(to: fileURL, atomically: true, encoding: .utf8)
                print("상갑 logEvent \(#function) success created \(fileURL.path)")
                self.showAlert("성공", "\(fileName) 파일이 생성되었습니다.")
                // Refresh list (reload from root project path)
                self.loadTargetTypeList(from: baseProjectURL)
                
                self.successCreateFile()
            }
        } catch {
            switch error {
            case let validateError as ValidateError:
                self.showAlert(validateError.alert)
            default:
                self.showAlert("에러", "파일 생성 중 오류가 발생했습니다.\n\(error.localizedDescription)")
            }
        }
    }
}

extension SettingViewModel {
    func validateProjectURL() throws -> URL {
        guard let baseProjectURL = self.projectURL else {
            throw ValidateError.missing(.projectURL)
        }
        
        return baseProjectURL
    }
}

extension SettingViewModel {
    func validateDisplayName(APITargetDescriptor model: APITargetDescriptor) throws -> APITargetDescriptor {
        guard !model.displayName.isEmpty else {
            throw ValidateError.missing(.displayName)
        }
        
        return model
    }
}

extension SettingViewModel {
    func validateCasseName(APITargetDescriptor model: APITargetDescriptor) throws {
        guard !model.caseName.isEmpty else {
            throw ValidateError.missing(.caseName)
        }
    }
}

extension SettingViewModel {
    func createDirectory(directoryPath: URL) throws {
        do {
            if !FileManager.default.fileExists(atPath: directoryPath.path) {
                try FileManager.default.createDirectory(at: directoryPath, withIntermediateDirectories: true, attributes: nil)
            }
        } catch {
            throw ValidateError.create(.folder(error.localizedDescription))
        }
    }
}
