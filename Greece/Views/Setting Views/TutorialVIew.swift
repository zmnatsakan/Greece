//
//  TutorialVIew.swift
//  Greece
//
//  Created by Mnatsakan Zurnadzhian on 22.01.24.
//

import SwiftUI

struct TutorialView: View {
    @State private var selectedIndex = 0
    @State private var progress: [CGFloat] = [0, 0, 0]
    @State private var isAutoProgressing = true
    @State private var timer: Timer? = nil
    
    var action = {}
    
    let tutorialImages = ["tutorialImage1", "tutorialImage2", "tutorialImage3"]
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedIndex) {
                    ForEach(0..<tutorialImages.count, id: \.self) { index in
                        Image(tutorialImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tag(index)
                            .clipShape(.rect(cornerRadius: 15))
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .disabled(true)
                .overlay {
                    VStack {
                        HStack(spacing: 4) {
                            ForEach(0..<tutorialImages.count, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.orange.opacity(0.3))
                                    .overlay(
                                        ProgressView(value: progress[index])
                                            .tint(.orange)
                                    )
                            }
                        }
                        .frame(height: 5)
                        .padding(.top, 10)
                        .padding(.horizontal, 35)
                        Spacer()
                    }
                }
            }
            HStack {
                Color.clear.contentShape(Rectangle())
                    .onTapGesture {
                        if selectedIndex > 0 {
                            timer?.invalidate()
                            progress[selectedIndex] = 1
                            let nextIndex = max((selectedIndex - 1), 0)
                            selectedIndex = nextIndex
                            progress[selectedIndex] = 0
                            startProgress()
                        } else {
                            print("END")
                        }
                    }
                Color.clear.contentShape(Rectangle())
                    .onTapGesture {
                        if selectedIndex < tutorialImages.count - 1 {
                            timer?.invalidate()
                            progress[selectedIndex] = 1
                            let nextIndex = min((selectedIndex + 1), tutorialImages.count - 1)
                            selectedIndex = nextIndex
                            progress[selectedIndex] = 0
                            startProgress()
                        } else {
                            action()
                        }
                    }
            }
        }
        .onAppear {
            startProgress()
        }
    }
    
    private func startProgress() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            if isAutoProgressing && selectedIndex < tutorialImages.count {
                self.progress[selectedIndex] += 0.005
                if (self.progress[selectedIndex] >= 0.99) {
                    timer.invalidate()
                    progress[selectedIndex] = 1
                    let nextIndex = selectedIndex + 1
                    selectedIndex = nextIndex
                    if selectedIndex != tutorialImages.count {
                        progress[selectedIndex] = 0
                        startProgress()
                    } else {
                        selectedIndex = tutorialImages.count - 1
                        isAutoProgressing = false
                    }
                }
            }
        }
    }
}



#Preview {
    TutorialView()
}
