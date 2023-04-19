
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
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            init_type = homecard.init_type
            showSecondView = true
        }
        .fullScreenCover(isPresented: $showSecondView) {
            withAnimation {
                ContentView(init_type: $init_type)
            }
        }
        
    }
}

struct HomeContentView: View {
    let cards: [HomeCard] = [
        HomeCard(imageName: "mobilenet", title: "Image Classification", description: "Card 1 description", init_type: 0),
        HomeCard(imageName: "yolo", title: "Object Detection", description: "Card 2 description", init_type: 1),
        HomeCard(imageName: "posenet", title: "Pose Estimation", description: "Card 3 description", init_type: 2)
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
            .navigationBarTitle("CV in Mobile", displayMode: .automatic)
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
