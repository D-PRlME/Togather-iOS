import SwiftUI
import Kingfisher

@available(iOS 16.0, *)
struct EditInfo: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name: String = ""
    @State var email: String = Account.email ?? "Email"
    @State var position: String = ""
    @State var introduce : String = ""
    
    @State var goBack: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    ColorManager.BackgroundColor.ignoresSafeArea()
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Image("CloseBtn")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.top, 16)
                                .onTapGesture {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                        }
                        HStack(spacing: 12) {
                            KFImage.url(URL(string: Account.profileImagLink ?? ""))
                                .placeholder {
                                    Circle().fill(Color.secondary)
                                        .frame(width: 48, height: 48)
                                }
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 48, height: 48)
                                .overlay(Circle().stroke().foregroundColor(Color("TabBarStroke")))
                                .padding(.leading, 10)
                            Text("이미지 변경")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 18))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                                .cornerRadius(37)
                                .padding(2)
                                .background(Color("YellowStroke"))
                                .cornerRadius(37)
                            Spacer()
                        }
                        .padding(.top, 26)
                        
                        //ID
                        TextField(Account.ID ?? "", text: $name)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                            .padding(12)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color("TabBarStroke"))
                            .cornerRadius(6)
                            .padding(.top, 12)
                        
                        //Email
                        VStack(alignment: .leading ,spacing: 0) {
                            Rectangle()
                                .frame(height: 0)
                            
                            Text(email)
                                .font(.custom("Pretendard-Medium", size: 20))
                                .foregroundColor(.secondary)
                                
                        }
                        .padding(12)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(6)
                        .padding(1)
                        .background(Color("TabBarStroke"))
                        .cornerRadius(6)
                        .padding(.top, 8)
                        
                        //Position
                        TextField("Position", text: $position)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                            .padding(12)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color("TabBarStroke"))
                            .cornerRadius(6)
                            .padding(.top, 12)
                        
                        //Introduce
                        TextField("Introduce", text: $introduce)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                            .padding(12)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .cornerRadius(6)
                            .padding(1)
                            .background(Color("TabBarStroke"))
                            .cornerRadius(6)
                            .padding(.top, 12)
                        
                        Spacer()
                        HStack {
                            Text("저장")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 18))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.882, green: 0.678, blue: 0.004))
                                .cornerRadius(37)
                                .padding(2)
                                .background(Color("YellowStroke"))
                                .cornerRadius(37)
                            Spacer()
                            NavigationLink(destination: DeleteAccount(goSignView: $goBack)) {
                                Text("계정 삭제")
                                    .foregroundColor(.black)
                                    .font(.custom("Pretendard-Bold", size: 18))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color(red: 0.995, green: 0.238, blue: 0.238))
                                    .cornerRadius(37)
                                    .padding(2)
                                    .background(Color("RedStroke"))
                                    .cornerRadius(37)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.bottom, 17)
                    }
                    .padding(.horizontal, 16)
                    .onAppear {
                        if goBack {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .fullScreenCover(isPresented: $goBack) {
                        NavigationView {
                            SignInView()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

@available(iOS 16.0, *)
struct EditInfo_Previews: PreviewProvider {
    static var previews: some View {
        EditInfo()
    }
}
