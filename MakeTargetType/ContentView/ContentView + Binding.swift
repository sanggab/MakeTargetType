//
//  ContentView + Binding.swift
//  MakeTargetType
//
//  Created by Gab on 2/2/26.
//

import SwiftUI

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
    
    var bindingCaseAssociatedValue: Binding<String> {
        Binding(
            get: { viewModel.apiTargetModel.caseAssociatedValue },
            set: { viewModel.updateCaseAssociatedValue($0) }
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

extension ContentView {
    func getBindingTaskInput(_ idx: Int) -> Binding<String> {
        switch idx {
        case 0:
            return bindingTaskInput1
        case 1:
            return bindingTaskInput2
        case 2:
            return bindingTaskInput3
        default:
            return .constant("")
        }
    }
    
    var bindingTaskInput1: Binding<String> {
        Binding(
            get: { viewModel.taskInputKey1 },
            set: { viewModel.updateTaskInputKey1(key: $0)}
        )
    }
    
    var bindingTaskInput2: Binding<String> {
        Binding(
            get: { viewModel.taskInputKey2 },
            set: { viewModel.updateTaskInputKey2(key: $0)}
        )
    }
    
    var bindingTaskInput3: Binding<String> {
        Binding(
            get: { viewModel.taskInputKey3 },
            set: { viewModel.updateTaskInputKey3(key: $0)}
        )
    }
}
