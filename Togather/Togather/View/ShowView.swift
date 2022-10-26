
import SwiftUI

struct ShowView: View {
    
    var Number: Int
    
    var body: some View {
        VStack {
            switch Number {
            case 1 :
                HomeView()
            case 2 :
                HomeView()
            case 3 :
                SearchView()
            case 4:
                MyView()
            default:
                HomeView()
            }
        }
    }
}
 
struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowView(Number: 1)
    }
}
