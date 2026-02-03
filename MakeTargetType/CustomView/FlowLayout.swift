//
//  FlowLayout.swift
//  MakeTargetType
//
//  Created by Gab on 2/2/26.
//

import SwiftUI

struct FlowLayout: Layout {
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
