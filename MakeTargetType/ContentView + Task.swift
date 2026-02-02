//
//  ContentView + Task.swift
//  MakeTargetType
//
//  Created by Gab on 2/2/26.
//

import SwiftUI

extension ContentView {
    @ViewBuilder
    var taskView: some View {
        HStack(spacing: 10) {
            Text("task")
                .frame(width: 100)
            
            Menu(viewModel.apiTargetModel.taskKind.rawValue) {
                ForEach(NetworkTaskKind.allCases, id: \.self) { kind in
                    Button {
                        viewModel.updateTaskKind(kind)
                    } label: {
                        Text(kind.rawValue)
                    }
                }
            }
            
            Spacer()
        }
        
        switch viewModel.apiTargetModel.taskKind {
        case .requestPlain:
            requestPlainView
            
        case .requestData:
            requestDataView
            
        case .requestJSONEncodable:
            requestJSONEncodableView
            
        case .requestCustomJSONEncodable:
            requestCustomJSONEncodableView
            
        case .requestParameters:
            requestParametersView
            
        case .requestCompositeData:
            requestCompositeDataView
            
        case .requestCompositeParameters:
            requestCompositeParametersView
            
        case .uploadFile:
            uploadFileView
            
        case .uploadMultipart:
            uploadMultipartView
            
        case .uploadCompositeMultipart:
            uploadCompositeMultipartView
            
        case .downloadDestination:
            downloadDestinationView
            
        case .downloadParameters:
            downloadParametersView
        }
        
        Divider()
    }
}

extension ContentView {
    @ViewBuilder
    var requestPlainView: some View {
        EmptyView()
    }
}

extension ContentView {
    @ViewBuilder
    var requestDataView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var requestJSONEncodableView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var requestCustomJSONEncodableView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var requestParametersView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var requestCompositeDataView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var requestCompositeParametersView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var uploadFileView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var uploadMultipartView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var uploadCompositeMultipartView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var downloadDestinationView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}

extension ContentView {
    @ViewBuilder
    var downloadParametersView: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.apiTargetModel.taskKind.placeHolder.enumerated()), id: \.element) { index, placeHolder in
                TextField(placeHolder, text: getBindingTaskInput(index))
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.leading, 100 + 10)
    }
}
