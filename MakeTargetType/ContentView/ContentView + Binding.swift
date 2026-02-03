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
