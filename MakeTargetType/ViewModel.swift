//
//  ViewModel.swift
//  MakeTargetType
//
//  Created by Gab on 1/27/26.
//

import SwiftUI
import Combine
import AppKit

struct AlertModel: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    
    init(
        title: String = "",
        message: String = ""
    ) {
        self.title = title
        self.message = message
    }
}

@Observable
final class SettingViewModel {
    private(set) var projectPath = ""
    private(set) var projectURL: URL?
    private(set) var targetTypeList: [String] = []
    private(set) var presentAlert = false
    private(set) var alertModel = AlertModel()
    private(set) var apiTargetModel = APITargetDescriptor()
    
    private(set) var headerKey = ""
    private(set) var headerValue = ""
    
    init() {
        let defaultHeaderItem = [
            HeaderItem(
                key: "Content-Type",
                value: "application/json"
            ),
            HeaderItem(
                key: "Accept-Language",
                value: "ko"
            ),
        ]
        
        self.apiTargetModel.headers.append(contentsOf: defaultHeaderItem)
    }
}

extension SettingViewModel {
    func selctedProjectPath() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        
        switch panel.runModal() {
        case .OK:
            if let url = panel.url {
                projectPath = url.path
                projectURL = url
                loadTargetTypeList(from: url)
            }
        case .cancel:
            break
        default:
            break
        }
    }
}

extension SettingViewModel {
    func loadTargetTypeList(from projectURL: URL) {
        let targetTypePath: URL = projectURL.appendingPathComponent("Core/NetWork/Sources/API/TargetType")
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: targetTypePath, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            self.targetTypeList = contents.filter { $0.hasDirectoryPath }.map { $0.lastPathComponent }
        } catch {
            print("상갑 logEvent \(#function) error \(error)")
            self.projectPath = ""
            self.showAlert(
                "에러",
                "TargetType을 찾을 수 없습니다. 경로를 올바르게 설정해주세요"
            )
        }
    }
}

extension SettingViewModel {
    func controlAlert(_ isPresented: Bool) {
        print("상갑 logEvent \(#function) isPresented \(isPresented)")
        self.presentAlert = isPresented
    }
    
    func showAlert(_ title: String, _ message: String) {
        self.alertModel = AlertModel(
            title: title,
            message: message
        )
        print("상갑 logEvent \(#function) alertModel \(alertModel)")
        self.presentAlert = true
    }
    
    func showAlert(_ model: AlertModel) {
        self.alertModel = model
        print("상갑 logEvent \(#function) alertModel \(alertModel)")
        self.presentAlert = true
    }
    
    func clearAlertModel() {
        self.alertModel = AlertModel()
        print("상갑 logEvent \(#function) alertModel \(alertModel)")
    }
}

extension SettingViewModel {
    func updateDisplayName(_ displayName: String) {
        guard self.apiTargetModel.displayName != displayName else { return }
        self.apiTargetModel.displayName = displayName
        print("상갑 logEvent \(#function) displayName \(self.apiTargetModel.displayName)")
    }
    
    func updateCaseName(_ caseName: String) {
        guard self.apiTargetModel.caseName != caseName else { return }
        self.apiTargetModel.caseName = caseName
        print("상갑 logEvent \(#function) caseName \(self.apiTargetModel.caseName)")
    }
    
    func updateBaseUrl(_ url: String) {
        guard self.apiTargetModel.baseUrl != url else { return }
        self.apiTargetModel.baseUrl = url
        print("상갑 logEvent \(#function) baseUrl \(self.apiTargetModel.baseUrl)")
    }
    
    func updatePath(_ path: String) {
        guard self.apiTargetModel.path != path else { return }
        self.apiTargetModel.path = path
        print("상갑 logEvent \(#function) path \(self.apiTargetModel.path)")
    }
    
    func updateHTTPMethod(_ method: String) {
        guard self.apiTargetModel.httpMethod.rawValue != method else { return }
        guard let httpMethod = HTTPMethod(rawValue: method) else { return }
        self.apiTargetModel.httpMethod = httpMethod
        print("상갑 logEvent \(#function) httpMethod \(self.apiTargetModel.httpMethod)")
    }
    
    func updateHeaderKey(key: String) {
        self.headerKey = key
    }
    
    func updateHeaderValue(value: String) {
        self.headerValue = value
    }
    
    func updateAPITargetHeader() {
        guard !self.headerKey.isEmpty, !self.headerValue.isEmpty else { return }
        // Array based addition
        let newItem = HeaderItem(key: self.headerKey, value: self.headerValue)
        self.apiTargetModel.headers.append(newItem)
        print("상갑 logEvent \(#function) added httpHeaders \(self.headerKey): \(self.headerValue)")
        self.headerKey = ""
        self.headerValue = ""
    }
    
    func removeHeader(id: UUID) {
        if let index = self.apiTargetModel.headers.firstIndex(where: { $0.id == id }) {
            self.apiTargetModel.headers.remove(at: index)
            print("상갑 logEvent \(#function) removed headers id: \(id)")
        }
    }
    
    func removeHeader(key: String) {
        // Fallback or convenient removal by key (removes first occurrence)
        if let index = self.apiTargetModel.headers.firstIndex(where: { $0.key == key }) {
            self.apiTargetModel.headers.remove(at: index)
            print("상갑 logEvent \(#function) removed headers key: \(key)")
        }
    }
    
    func createTargetTypeFile() {
        guard let baseProjectURL = self.projectURL else {
            self.showAlert("에러", "프로젝트 경로가 설정되지 않았습니다.")
            return
        }
        
        let targetModel = self.apiTargetModel
        
        guard !targetModel.displayName.isEmpty else {
            self.showAlert("에러", "Display Name(모델 네이밍)을 입력해주세요.")
            return
        }
        
        let targetTypeName = "\(targetModel.displayName)TargetType"
        let fileName = "\(targetTypeName).swift"
        // Construct path: projectPath/Core/NetWork/Sources/API/TargetType/displayName
        let directoryPath = baseProjectURL.appendingPathComponent("Core/NetWork/Sources/API/TargetType").appendingPathComponent(targetModel.displayName)
        
        let fileURL = directoryPath.appendingPathComponent(fileName)
        
        let fileManager = FileManager.default
        
        do {
            if !fileManager.fileExists(atPath: directoryPath.path) {
                try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: true, attributes: nil)
            }
        } catch {
             showAlert("에러", "폴더 생성 실패: \(error.localizedDescription)")
             return
        }
        
        if fileManager.fileExists(atPath: fileURL.path) {
            self.showAlert("실패", "\(fileName) 파일이 이미 존재합니다.")
            return
        }
        
        // Ensure makeTargetTypeDefault returns String. It's in Template.swift (global func inferred).
        let content = makeTargetTypeDefault(APITargetDescriptor: apiTargetModel)
        
        do {
            print("상갑 logEvent \(#function) filURL \(fileURL.path)")
            
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            print("상갑 logEvent \(#function) success created \(fileURL.path)")
            self.showAlert("성공", "\(fileName) 파일이 생성되었습니다.")
            // Refresh list (reload from root project path)
            self.loadTargetTypeList(from: baseProjectURL)
        } catch {
            print("상갑 logEvent \(#function) error \(error)")
            self.showAlert("에러", "파일 생성 중 오류가 발생했습니다.\n\(error.localizedDescription)")
        }
    }
}
