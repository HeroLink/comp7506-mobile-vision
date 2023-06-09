
import SwiftUI

struct HomeCard: Identifiable {
    var id = UUID()
    var imageName: String
    var title: String
    var description: String
    var init_type: Int
}

struct HomeCardView: View {
    let homecard: HomeCard
    @State private var showSecondView = false
    @State private var init_type = -1
    @State private var bgColor = Color.white
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(homecard.title)
                .font(.title2)
                .padding(.top)
                .padding(.leading)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text(homecard.description)
                .foregroundColor(.black)
                .padding(.leading)
            Image(homecard.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 250)
                .clipped()
        }
        .background(bgColor)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            init_type = homecard.init_type
            showSecondView = true
        }
        // When view is tapped or pressed, bgColor will be changed to light gray
        .onLongPressGesture (pressing: { isPressing in
            bgColor = isPressing ? Color(red: 0.8, green: 0.8, blue: 0.8) : .white
        }, perform: {
            bgColor = .white
        })
        .fullScreenCover(isPresented: $showSecondView) {
            withAnimation {
                CardView(init_type: $init_type)
            }
        }
    }
}

struct HomeContentView: View {
    let cards: [HomeCard] = [
        HomeCard(imageName: "y0", title: "Object Detection", description: "Real-time Locate and classify objects", init_type: 0),
        HomeCard(imageName: "p1", title: "Pose Estimation", description: "Real-time Detect body joints and parts", init_type: 1),
        HomeCard(imageName: "m1", title: "Image Classification", description: "Categorize images into predefined classes", init_type: 2)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(cards) { card in
                        HomeCardView(homecard: card)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Mobile Vision", displayMode: .automatic)
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
