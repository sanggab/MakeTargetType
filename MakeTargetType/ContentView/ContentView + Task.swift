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
        
        Divider()
    }
}
