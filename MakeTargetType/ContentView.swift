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
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                
                selectedProjectPathView
                
                Divider()
                
                targetTypeListView
                
                inputList
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
    @ViewBuilder
    var selectedProjectPathView: some View {
        HStack {
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
            HStack {
                Text("TargetType 리스트: ")
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.targetTypeList, id: \.self) { id in
                            Button {
                                viewModel.updateDisplayName(id)
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
    var inputList: some View {
        VStack {
            HStack {
                Text("모델 네이밍")
                    .frame(width: 100)
                
                TextField("ex) AppTargetType에서 App에 해당하는 부분", text: bindingDisplayName)
            }
            
            HStack {
                Text("case")
                    .frame(width: 100)
                
                TextField("enum case 이름", text: bindingCaseName)
            }
            
            HStack {
                Text("baseURL")
                    .frame(width: 100)
                
                TextField("baseURL 주소", text: bindingBaseUrl)
            }
            
            HStack {
                Text("path")
                    .frame(width: 100)
                
                TextField("path 주소", text: bindingPath)
            }
            
            HStack {
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
            
            VStack(alignment: .leading) {
                HStack {
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
                                    .font(.system(size: 16))
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background(.gray.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .onTapGesture {
                                viewModel.removeHeader(id: item.id)
                            }
                        }
                    }
                    .padding(.leading, 100)
                }
            }
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
    
    var bindingDisplayName: Binding<String> {
        Binding(
            get: { viewModel.apiTargetModel.displayName },
            set: { viewModel.updateDisplayName($0) }
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
    
    var bindingHeaderKey: Binding<String> {
        Binding(
            get: { viewModel.headerKey },
            set: { viewModel.updateHeaderKey(key: $0) }
        )
    }
    
    var bindingHeaderValue: Binding<String> {
        Binding(
            get: { viewModel.headerValue },
            set: { viewModel.updateHeaderValue(value: $0) }
        )
    }
}

fileprivate struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        let height = rows.reduce(CGFloat.zero) { $0 + $1.height + spacing } - (rows.isEmpty ? 0 : spacing)
        let width = rows.reduce(CGFloat.zero) { max($0, $1.width) }
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        var y = bounds.minY
        for row in rows {
            var x = bounds.minX
            for item in row.items {
                item.view.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
                x += item.size.width + spacing
            }
            y += row.height + spacing
        }
    }
    
    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [Row] {
        var rows: [Row] = []
        var currentRow = Row()
        let maxWidth = proposal.width ?? .infinity
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentRow.width + size.width + spacing > maxWidth {
                rows.append(currentRow)
                currentRow = Row()
            }
            currentRow.add(subview: subview, size: size, spacing: spacing)
        }
        if !currentRow.items.isEmpty { rows.append(currentRow) }
        return rows
    }
    
    struct Row {
        var items: [(view: LayoutSubview, size: CGSize)] = []
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        mutating func add(subview: LayoutSubview, size: CGSize, spacing: CGFloat) {
            if !items.isEmpty { width += spacing }
            items.append((subview, size))
            width += size.width
            height = max(height, size.height)
        }
    }
}

#Preview {
    ContentView()
}
