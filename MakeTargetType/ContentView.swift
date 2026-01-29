//
//  ContentView.swift
//  MakeTargetType
//
//  Created by Gab on 1/27/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    var viewModel: SettingViewModel = .init()
    
    @State var hi: String = ""
    
    var body: some View {
        let _ = Self._printChanges()
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                HStack {
                    Text("프로젝트 경로")
                    
                    Button {
                        viewModel.selctedProjectPath()
                    } label: {
                        Text("경로: \(viewModel.projectPath)")
                    }
                }
                
                Divider()
                
                if !viewModel.targetTypeList.isEmpty {
                    HStack {
                        Text("TargetType 리스트: ")
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(viewModel.targetTypeList, id: \.self) { id in
                                    Button {
                                        
                                    } label: {
                                        Text(id)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    Divider()
                }
                
                VStack {
                    HStack {
                        Text("case: ")
                        
                        TextField("enum case 이름", text: bindingCaseName)
                    }
                    
                    HStack {
                        Text("baseURL: ")
                        
                        TextField("baseURL 주소", text: bindingBaseUrl)
                    }
                    
                    HStack {
                        Text("path: ")
                        
                        TextField("path 주소", text: bindingPath)
                    }
                    
                    HStack {
                        Text("httpMethod: ")
                        
                        Menu(viewModel.apiTargetModel.httpMethod.rawValue) {
                            ForEach(HTTPMethod.allCases, id: \.self) { method in
                                Button {
                                    viewModel.updateHTTPMethod(method.rawValue)
                                } label: {
                                    Text(method.rawValue)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("case: ")
                        
                        TextField("enum case 이름", text: bindingCaseName)
                    }
                }
                
            }
            .padding(.all, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .alert(
            viewModel.alertModel.title,
            isPresented: isPresented
        ) {
            Button("확인", role: .cancel) {
                self.viewModel.clearAlertModel()
            }
        } message: {
            Text(viewModel.alertModel.message)
        }
    }
}

extension ContentView {
    var isPresented: Binding<Bool> {
        Binding(
            get: { viewModel.presentAlert },
            set: { viewModel.controlAlert($0) }
        )
    }
    
    var bindingCaseName: Binding<String> {
        Binding(
            get: { viewModel.apiTargetModel.caseName },
            set: { viewModel.updateCaseName($0) }
        )
    }
    
    var bindingBaseUrl: Binding<String> {
        Binding(
            get: { viewModel.apiTargetModel.baseUrl },
            set: { viewModel.updateBaseUrl($0) }
        )
    }
    
    var bindingPath: Binding<String> {
        Binding(
            get: { viewModel.apiTargetModel.path },
            set: { viewModel.updatePath($0) }
        )
    }
    
    var bindingHTTPMethod: Binding<String> {
        Binding(
            get: { viewModel.apiTargetModel.httpMethod.rawValue },
            set: { viewModel.updateHTTPMethod($0) }
        )
    }
    
//    var bindingHeaders: Binding<[String: String]> {
//        Binding(
//            get: { viewModel.apiTargetModel.caseName },
//            set: { viewModel.updateCaseName($0) }
//        )
//    }
}

#Preview {
    ContentView()
}
