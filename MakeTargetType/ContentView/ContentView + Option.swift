//
//  ContentView + Option.swift
//  MakeTargetType
//
//  Created by Gab on 2/4/26.
//

import SwiftUI

extension ContentView {
    @ViewBuilder
    var optionView: some View {
        VStack(alignment: .leading) {
            Text("설정")
            
            Divider()
            
            HStack {
                Toggle(isOn: isFolderBinding) {
                    Text("폴더 생성")
                }
                .toggleStyle(.checkbox) // macOS 스타일 체크박스
                
                Spacer()
                
                Button("?") {
                    viewModel.showAlert(
                        "정보",
                        "만들어진 TargetType.swift를 폴더를 만들어서 넣을 지 아니면 지정한 경로에 그냥 파일을 생성할 지 결정합니다."
                    )
                }
            }
            
        }
        .padding()
        .frame(width: 300)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .transition(.slide)
    }
}

extension ContentView {
    var isFolderBinding: Binding<Bool> {
        Binding(
            get: { viewModel.isFolder },
            set: { viewModel.updateIsFolder($0) }
        )
    }
}
