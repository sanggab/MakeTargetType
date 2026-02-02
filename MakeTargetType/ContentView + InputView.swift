//
//  ContentView + InputView.swift
//  MakeTargetType
//
//  Created by Gab on 2/2/26.
//

import SwiftUI

extension ContentView {
    @ViewBuilder
    var inputList: some View {
        VStack(spacing: 15) {
            displayNameView
            
            caseNameView
            
            baseURLNameView
            
            pathView
            
            httpMethodView
            
            taskView
            
            headersView
            
            createFileView
        }
    }
}

extension ContentView {
    @ViewBuilder
    var displayNameView: some View {
        HStack(spacing: 10) {
            Text("모델 네이밍")
                .frame(width: 100)
            
            TextField("ex) AppTargetType에서 App에 해당하는 부분", text: bindingDisplayName)
        }
        
        Divider()
    }
}

extension ContentView {
    @ViewBuilder
    var caseNameView: some View {
        HStack(spacing: 10) {
            Text("case")
                .frame(width: 100)
            
            TextField("enum case 이름", text: bindingCaseName)
        }
        
        Divider()
    }
}


extension ContentView {
    @ViewBuilder
    var baseURLNameView: some View {
        HStack(spacing: 10) {
            Text("baseURL")
                .frame(width: 100)
            
            TextField("baseURL 주소", text: bindingBaseUrl)
        }
        
        Divider()
    }
}


extension ContentView {
    @ViewBuilder
    var pathView: some View {
        HStack(spacing: 10) {
            Text("path")
                .frame(width: 100)
            
            TextField("path 주소", text: bindingPath)
        }
        
        Divider()
    }
}


extension ContentView {
    @ViewBuilder
    var httpMethodView: some View {
        HStack(spacing: 10) {
            Text("httpMethod")
                .frame(width: 100)
            
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
        
        Divider()
    }
}


extension ContentView {
    @ViewBuilder
    var headersView: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Text("headers")
                    .frame(width: 100)
                
                VStack {
                    TextField("Key", text: bindingHeaderKey)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Value", text: bindingHeaderValue)
                        .textFieldStyle(.roundedBorder)
                }
                
                Button {
                    viewModel.updateAPITargetHeader()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(self.viewModel.headerKey.isEmpty || self.viewModel.headerValue.isEmpty)
            }
            
            if !viewModel.apiTargetModel.headers.isEmpty {
                FlowLayout(spacing: 8) {
                    ForEach(viewModel.apiTargetModel.headers) { item in
                        HStack(spacing: 4) {
                            Text("\(item.key): \(item.value)")
                                .font(.system(size: 15))
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                            
                            Button {
                                viewModel.removeHeader(id: item.id)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.leading, 100 + 10)
                .padding(.top, 4)
            }
        }
        
        Divider()
    }
}


extension ContentView {
    @ViewBuilder
    var createFileView: some View {
        HStack {
            Spacer()
            Button {
                viewModel.createTargetTypeFile()
            } label: {
                Text("파일 생성하기")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.apiTargetModel.displayName.isEmpty || viewModel.projectPath.isEmpty)
        }
        .padding(.top, 20)
    }
}

