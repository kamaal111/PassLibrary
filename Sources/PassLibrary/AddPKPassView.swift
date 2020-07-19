//
//  AddPKPassView.swift
//  PassLibrary
//
//  Created by Kamaal Farah on 19/07/2020.
//

import SwiftUI
import PassKit

@available(iOS 13.0, *)
public final class AddPKPassHandler: ObservableObject {
    @Published public var showAddPassView = false
    @Published public var pass: PKPass?
    @Published public var failures: Error? {
        didSet {
            #if DEBUG
            if let failures = self.failures {
                print("AddPKPassHandler ERROR:", failures)
            }
            #endif
        }
    }

    private let networker = Networker()

    public init() { }

    public enum AddPKPassHandlerErrors: Error {
        case failedToUnwrap(message: String)
    }

    public func getAndSetPKPass(from urlPath: String) {
        self.networker.getPKPass(from: urlPath) { (result: Result<Data, Error>) in
            switch result {
            case .failure(let error):
                self.failures = error
            case .success(let data):
                var pass: PKPass?
                do {
                    pass = try PKPass(data: data)
                } catch {
                    self.failures = error
                }
                guard pass != nil else {
                    self.failures = AddPKPassHandlerErrors.failedToUnwrap(message: "Failed to unwrap value of pass")
                    return
                }
                DispatchQueue.main.async {
                    self.pass = pass
                    self.showAddPassView = true
                }
            }
        }
    }
}

internal struct AddPKPassViewContent: UIViewControllerRepresentable {
    internal let passes: [PKPass]

    internal init(passes: [PKPass]?) {
        self.passes = passes ?? []
    }

    internal init(pass: PKPass?) {
        if let pass = pass {
            self.passes = [pass]
        } else {
            self.passes = []
        }
    }

    func makeUIViewController(context: Context) -> UIViewControllerType {
        let pkAddPassViewController = PKAddPassesViewController(passes: self.passes)
        return pkAddPassViewController ?? PKAddPassesViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    typealias UIViewControllerType = PKAddPassesViewController
}

@available(iOS 13.0, *)
public struct AddPKPassView<Presenting>: View where Presenting: View {
    @Binding public var isShowing: Bool

    public var presenting: () -> Presenting
    public var passes: [PKPass]?

    public init(isShowing: Binding<Bool>, presenting: @escaping () -> Presenting, passes: [PKPass]?) {
        self._isShowing = isShowing
        self.presenting = presenting
        self.passes = passes
    }

    public var body: some View {
        self.presenting()
            .sheet(isPresented: self.$isShowing) {
                ZStack {
                    AddPKPassViewContent(passes: self.passes)
                }
        }
    }
}

@available(iOS 13.0, *)
public extension View {
    func addPKPassSheet(isShowing: Binding<Bool>, pass: PKPass? = nil) -> some View {
        var passes: [PKPass] = []
        if let pass = pass {
            passes.append(pass)
        }
        return AddPKPassView(isShowing: isShowing, presenting: { self }, passes: passes)
    }
}
