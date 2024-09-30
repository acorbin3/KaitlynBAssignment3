//
//  ExerciseView.swift
//  Assignment3
//
//  Created by Kaitlyn Bracey on 9/30/24.
//


import SwiftUI

struct ExerciseView: View {
  @State private var rating = 0
  @State private var showHistory = false
  @State private var showSuccess = false
  @Binding var selectedTab: Int
  let index: Int

  var exercise: Exercise {
    Exercise.exercises[index]
  }
  var lastExercise: Bool {
    index + 1 == Exercise.exercises.count
  }

  var startButton: some View {
      Button("Start Exercise") {
       showTimer.toggle()
          //button that toggles a boolean
      }
  }

  var doneButton: some View {
    Button("Done") {
        timerDone = false
        //resets to false to disable the done button
        showTimer.toggle()
        if lastExercise {
        showSuccess.toggle()
      } else {
        selectedTab += 1
      }
    }
  }

    @State private var timerDone = false
    @State private var showTimer = false
    // will pass timerDone to TimerView, which will set it to true when the timer reaches zero, then enable done button
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(
                    selectedTab: $selectedTab,
                    titleText: Exercise.exercises[index].exerciseName)
                .padding(.bottom)

                VideoPlayerView(videoName: exercise.videoName)
                    .frame(height: geometry.size.height * 0.45)

//                    if showTimer {
//                        TimerView(
//                            timerDone: $timerDone,
//                            size: geometry.size.height * 0.07
//                        )
//                    }
//
//                HStack(spacing: 150) {
//                    startButton
//                    doneButton
//                        .disabled(!timerDone)
//                    //disables the done button while timerDone is false
//                        .sheet(isPresented: $showSuccess) {
//                            SuccessView(selectedTab: $selectedTab)
//                                .presentationDetents([.medium, .large])
//            }
//        }
//        .font(.title3)
//        .padding()
//
//        RatingView(rating: $rating)
//          .padding()
//
//        Spacer()
// commented out per page 180
                
        HStack(spacing: 150) {
            startButton
            doneButton
                .disabled(!timerDone)
                .sheet(isPresented: $showSuccess) {
                SuccessView(selectedTab: $selectedTab)
                .presentationDetents([.medium, .large])
                }
               }
               .font(.title3)
               .padding()
               if showTimer {
                TimerView(
                timerDone: $timerDone,
                size: geometry.size.height * 0.07
                )
               }
               Spacer()
               RatingView(rating: $rating)
                .padding()
        Button("History") {
          showHistory.toggle()
        }
        .sheet(isPresented: $showHistory) {
          HistoryView(showHistory: $showHistory)
        }
          .padding(.bottom)
      }
    }
  }
}

struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
      ExerciseView(selectedTab: .constant(3), index: 3)  }
}
