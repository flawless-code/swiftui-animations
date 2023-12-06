//
//  ReactionButton.swift
//  SwiftUIAnimations
//
//  Created by Kavinkumar on 05/12/23.
//


import SwiftUI

enum Reaction: String, CaseIterable {
    
    case smile = "smile"
    case love = "love"
    case laugh = "laugh"
    case surprise = "surprise"
    case cry = "cry"
    case angry = "angry"
    
    var imageName: String { rawValue }
    
}

struct ReactionButton<Content>: View where Content : View {
    
    @State private var showReactions = false
    @State private var selectedReaction: Reaction?
    
    @ViewBuilder var content: (Reaction?) -> Content
    var onReactionSelected: ((Reaction?) -> Void)?
    
    init(@ViewBuilder content: @escaping (Reaction?) -> Content, onReactionSelected: ((Reaction?) -> Void)? = nil) {
        self.content = content
        self.onReactionSelected = onReactionSelected
    }
    
    var body: some View {
        Button {
            showReactions.toggle()
        } label: {
            content(selectedReaction)
        }
        .overlay(alignment: .top) {
            HStack(spacing: 5) {
                ForEach(0..<Reaction.allCases.count, id: \.self) { index in
                    let reaction = Reaction.allCases[index]
                    
                    Button {
                        showReactions = false
                        selectedReaction = selectedReaction == reaction ? nil : reaction
                    } label: {
                        Image(reaction.imageName)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .frame(width: 35, height: 35)
                    .background(selectedReaction == reaction ? Color.gray.opacity(0.25) : Color.clear)
                    .clipShape(Circle())
                    .opacity(showReactions ? 1.0 : 0)
                    .offset(y: showReactions ? 0 : 5)
                    .rotation3DEffect(.degrees(showReactions ? 0 : 45), axis: (0, 0, 1))
                    .animation(.easeInOut.delay(0.05 * Double(index)), value: showReactions)
                }
            }
            .padding(.all, 10)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(color: Color.black.opacity(0.09),radius: 10)
            .offset(y: -65)
            .opacity(showReactions ? 1.0 : 0)
            .animation(.easeIn, value: showReactions)
        }
    }
}

#Preview {
    ReactionButton { reaction in
        Label {
            if let reaction {
                Image(reaction.imageName)
                    .resizable()
                    .frame(width: 25, height: 25)
            } else {
                EmptyView()
            }
        } icon: {
            Text(reaction == nil ? "Show Reactions" : "Reaction")
        }

    }
}
