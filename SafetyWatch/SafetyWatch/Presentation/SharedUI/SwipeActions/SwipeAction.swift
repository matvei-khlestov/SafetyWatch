//
//  SwipeAction.swift
//  SafetyWatch
//
//  Created by Matvei Khlestov on 02.01.2026.
//

import SwiftUI

struct SwipeAction<Content: View>: View {

    let id: AnyHashable
    @Bindable var coordinator: SwipeCoordinator

    var cornerRadius: CGFloat = 0
    @ViewBuilder var content: Content
    @SwipeActionBuilder var actions: [SwipeActionItem]

    @Environment(\.colorScheme) private var scheme

    private var viewID: AnyHashable { "CONTENTVIEW_\(id)" }

    @State private var isEnabled: Bool = true
    @State private var scrollOffset: CGFloat = .zero

    var body: some View {
        ScrollViewReader { scrollProxy in
            scrollView(scrollProxy: scrollProxy)
        }
        .allowsHitTesting(isEnabled)
        .transition(SwipeCustomTransition())
    }

    // MARK: - Building blocks

    private func scrollView(scrollProxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                contentBlock
                    .id(viewID)
                    .background(leadingTintBackground)

                actionsBlock(scrollProxy: scrollProxy)
                    .opacity(isClosed ? 0 : 1)
            }
            .scrollTargetLayout()
            .modifier(SwipeOffsetVisualEffect())
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .background(trailingTintBackground)
        .clipShape(.rect(cornerRadius: cornerRadius))
        .onChange(of: coordinator.activeID) { _, newValue in
            closeIfNeeded(newValue: newValue, scrollProxy: scrollProxy)
        }
    }

    private var contentBlock: some View {
        content
            .contentShape(.rect)
            .containerRelativeFrame(.horizontal)
            .background(scheme == .dark ? .black : .white)
            .transition(.identity)
            .overlay(offsetReader)
            .onPreferenceChange(SwipeOffsetKey.self, perform: handleOffsetChange)
            .simultaneousGesture(dragToActivateGesture)
    }

    private func actionsBlock(scrollProxy: ScrollViewProxy) -> some View {
        actionButtons(
            actions: enabledActions,
            resetPosition: {
                withAnimation(.snappy) {
                    scrollProxy.scrollTo(viewID, anchor: .topLeading)
                }
            }
        )
    }

    // MARK: - Reader

    private var offsetReader: some View {
        GeometryReader { geo in
            let minX = geo.frame(in: .scrollView(axis: .horizontal)).minX
            Color.clear.preference(key: SwipeOffsetKey.self, value: minX)
        }
    }

    // MARK: - Backgrounds

    private var leadingTintBackground: some View {
        Group {
            if let first = enabledActions.first {
                Rectangle()
                    .fill(first.tint)
                    .opacity(isClosed ? 0 : 1)
            }
        }
    }

    private var trailingTintBackground: some View {
        Group {
            if let last = enabledActions.last {
                Rectangle()
                    .fill(last.tint)
                    .opacity(isClosed ? 0 : 1)
            }
        }
    }

    // MARK: - Actions UI

    private func actionButtons(
        actions: [SwipeActionItem],
        resetPosition: @escaping () -> Void
    ) -> some View {
        Rectangle()
            .fill(.clear)
            .frame(width: CGFloat(actions.count) * SwipeMetrics.actionWidth)
            .overlay(alignment: .trailing) {
                HStack(spacing: 0) {
                    ForEach(actions) { button in
                        Button {
                            Task { @MainActor in
                                isEnabled = false
                                resetPosition()
                                try? await Task.sleep(for: .seconds(SwipeMetrics.resetDelay))
                                button.action()
                                try? await Task.sleep(for: .seconds(SwipeMetrics.afterActionDelay))
                                isEnabled = true
                            }
                        } label: {
                            Image(systemName: button.icon)
                                .font(button.iconFont)
                                .foregroundStyle(button.iconTint)
                                .frame(width: SwipeMetrics.actionWidth)
                                .frame(maxHeight: .infinity)
                                .contentShape(.rect)
                        }
                        .buttonStyle(.plain)
                        .background(button.tint)
                    }
                }
            }
    }

    // MARK: - Gestures

    private var dragToActivateGesture: some Gesture {
        DragGesture(minimumDistance: SwipeMetrics.dragMinDistance)
            .onChanged { value in
                guard isHorizontalDrag(value) else { return }
                coordinator.setActive(id)
            }
    }

    // MARK: - Logic

    private var isClosed: Bool { scrollOffset == .zero }

    private var enabledActions: [SwipeActionItem] {
        actions.filter { $0.isEnabled }
    }

    private func handleOffsetChange(_ newValue: CGFloat) {
        scrollOffset = newValue
        if newValue == .zero, coordinator.activeID == id {
            coordinator.activeID = nil
        }
    }

    private func closeIfNeeded(newValue: AnyHashable?, scrollProxy: ScrollViewProxy) {
        guard newValue != id, scrollOffset != .zero else { return }
        withAnimation(.snappy) {
            scrollProxy.scrollTo(viewID, anchor: .topLeading)
        }
    }

    private func isHorizontalDrag(_ value: DragGesture.Value) -> Bool {
        abs(value.translation.width) > abs(value.translation.height)
    }
}

// MARK: - VisualEffect вынесен в отдельный ViewModifier

private struct SwipeOffsetVisualEffect: ViewModifier {
    func body(content: Content) -> some View {
        content.visualEffect { v, proxy in
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            return v.offset(x: minX > 0 ? -minX : 0)
        }
    }
}
