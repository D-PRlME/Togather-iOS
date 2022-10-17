import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

@available(iOS 16.0, *)
struct EditInfo: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var changeMyInfoVM = ChangeMyInfoViewModel()
    @State var goBack: Bool = false
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    let introduceTextLimit: Int = 100
    let positionList: [String] = ["PM", "웹 프론트엔드", "백엔드", "안드로이드", "iOS", "디자인"]
    
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
                            KFImage.url(URL(string: Account.profileImagLink ?? "이메일"))
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
                        TextField("이름", text: $changeMyInfoVM.name)
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
                            
                            Text(Account.email ?? "")
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
                    
                        
                        //Introduce
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $changeMyInfoVM.introduce)
                                .scrollContentBackground(.hidden)
                                .font(.custom("Pretendard-Medium", size: 20))
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 12, leading: 10, bottom: 30, trailing: 10))
                                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                                .cornerRadius(5)
                                .padding(1)
                                .background(Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                                .cornerRadius(6)
                            
                            VStack {
                                HStack {
                                    if(changeMyInfoVM.introduce.count <= 0) {
                                        Text("소개")
                                            .font(.custom("Pretendard-Medium", size: 20))
                                            .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                                            .padding(.leading, 15)
                                            .padding(.top, 20)
                                    } //플레이스 홀더
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    Text("\(changeMyInfoVM.introduce.count)/\(introduceTextLimit)")
                                        .font(.custom("Pretendard-Medium", size: 20))
                                        .foregroundColor(changeMyInfoVM.introduce.count < introduceTextLimit ? Color(red: 0.75, green: 0.75, blue: 0.75) : .red)
                                        .padding(.trailing, 10)
                                        .padding(.bottom, 5)
                                }
                            }
                        }
                        .onChange(of: changeMyInfoVM.introduce) { newValue in
                            if(newValue.count > introduceTextLimit) {
                                changeMyInfoVM.introduce.removeLast()
                            }
                        }
                        .frame(minHeight: 48, maxHeight: 48 * 3)
                        .padding(.vertical, 8)
                        
                        VStack {
                            HStack {
                                Text("내 포지션")
                                    .font(.custom("Pretendard-ExtraBold", size: 14))
                                    .foregroundColor(.black.opacity(0.5))
                                
                                Spacer()
                            }
                            
                            FlowLayout(mode: .scrollable,
                                       items: positionList,
                                       itemSpacing: 2) { index in
                                
                                Text(index)
                                    .foregroundColor(.black)
                                    .font(.custom("Pretendard-Medium", size: 16))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(changeMyInfoVM.positions.contains(index.PositionTypeChange) ? Color(red: 0.925, green: 0.792, blue: 0.357) : Color(red: 0.905, green: 0.905, blue: 0.905))
                                    .cornerRadius(37)
                                    .padding(1)
                                    .background(changeMyInfoVM.positions.contains(index.PositionTypeChange) ? Color("YellowStroke") : Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                                    .cornerRadius(37)
                                    .onTapGesture {
                                        if changeMyInfoVM.positions.contains(index.PositionTypeChange) {
                                            changeMyInfoVM.positions.removeAll { $0 == index.PositionTypeChange }
                                        } else {
                                            changeMyInfoVM.positions.append(index.PositionTypeChange)
                                        }
                                    }
                            }
                        }
                        
                        Spacer()
                        HStack {
                            Button {
                                if (changeMyInfoVM.introduce.count <= introduceTextLimit) {
                                    changeMyInfoVM.changeMyInfo()
                                } else {
                                    alertMessage = "소개 글자수는 100자 이하입니다."
                                    showAlert = true
                                }
                            } label: {
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
                            }
                            
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
                            .alert("안내", isPresented: $showAlert) {
                                Button("확인", role: .cancel) { }
                            } message: {
                                Text(alertMessage)
                            }
                        }
                        .padding(.bottom, 17)
                    }
                    .padding(.horizontal, 16)
                    .onAppear {
                        if goBack {
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            changeMyInfoVM.getMyInfo()
                        }
                    }
                    .fullScreenCover(isPresented: $goBack) {
                        NavigationView {
                            LoginView()
                        }
                    }
                    .alert("안내", isPresented: $changeMyInfoVM.showingAlert) {
                        Button("확인", role: .cancel) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } message: {
                        Text("프로필을 수정하였습니다.")
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
