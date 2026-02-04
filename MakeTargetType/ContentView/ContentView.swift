//
//  ContentView.swift
//  MakeTargetType
//
//  Created by Gab on 1/27/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var viewModel: SettingViewModel = .init()
    
    @State var hi: String = ""
    
    var body: some View {
        let _ = Self._printChanges()
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                
                selectedProjectPathView
                
                Divider()
                
                targetTypeListView
                
                inputList
                
                createFileView
            }
            
            optionView
            
        }
        .padding(.all, 10)
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
    @ViewBuilder
    var selectedProjectPathView: some View {
        HStack(spacing: 10) {
            Text("프로젝트 경로")
            
            Button {
                viewModel.selctedProjectPath()
            } label: {
                Text("경로: \(viewModel.projectPath)")
            }
        }
    }
}

extension ContentView {
    @ViewBuilder
    var targetTypeListView: some View {
        if !viewModel.targetTypeList.isEmpty {
            HStack(spacing: 10) {
                Text("TargetType 리스트: ")
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.targetTypeList, id: \.self) { id in
                            Button {
                                viewModel.selectedTargetType(id)
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
        } else {
            EmptyView()
        }
    }
}

extension ContentView {
    @ViewBuilder
    var createFileView: some View {
        HStack {
            Spacer()
            Button {
//                viewModel.createTargetTypeFile()
                viewModel.isFolder ? viewModel.createTargetTypeFileWithFolder() : viewModel.createTargetTypeFile()
            } label: {
                Text("파일 생성하기")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
//                    .disabled(viewModel.apiTargetModel.displayName.isEmpty || viewModel.projectPath.isEmpty)
            }
//            .disabled(viewModel.apiTargetModel.displayName.isEmpty || viewModel.projectPath.isEmpty)
        }
        .padding(.top, 20)
    }
}


#Preview {
    ContentView()
}
