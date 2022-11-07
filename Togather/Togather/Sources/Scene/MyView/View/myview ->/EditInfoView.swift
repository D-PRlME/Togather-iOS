import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct EditInfo: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var changeMyInfoVM = ChangeMyInfoViewModel()
    @State private var goBack: Bool = false
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var showImagePicker: Bool = false
    
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
                            KFImage.url(URL(string: changeMyInfoVM.profileImageLink))
                                .placeholder {
                                    Circle().fill(Color.whiteElevated3)
                                        .frame(width: 48, height: 48)
                                }
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 48, height: 48)
                                .overlay(Circle().stroke().foregroundColor(.whiteElevated3))
                            Button  {
                                self.showImagePicker.toggle()
                            } label: {
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
                            }
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(image: $changeMyInfoVM.image)
                            }
                            .onChange(of: selectedImage) { newValue in
//                                changeMyInfoVM.
                            }
                            Spacer()
                        }
                        .padding(.top, 26)
                        
                        
                        //ID
                        EditInfoTextField(
                            placeholder: "이름",
                            text: $changeMyInfoVM.name
                        )
                        .padding(.top, 12)
                        
                        //Email
                        VStack(alignment: .leading ,spacing: 0) {
                            Rectangle()
                                .frame(height: 0)
                            
                            Text(Account.email ?? "")
                                .font(.title3m)
                                .foregroundColor(.whiteElevated4)
                                
                        }
                        .padding(12)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .cornerRadius(6)
                        .padding(1)
                        .background(Color.whiteElevated3)
                        .cornerRadius(6)
                        .padding(.top, 8)
                    
                        
                        //Introduce
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $changeMyInfoVM.introduce)
//                                .scrollContentBackground(.hidden)
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
                                    .font(.indicator)
                                    .foregroundColor(.whiteElevated4)
                                
                                Spacer()
                            }
                            
                            FlowLayout(mode: .scrollable,
                                       items: positionList,
                                       itemSpacing: 2) { index in
                                
                                Text(index)
                                    .foregroundColor(.black)
                                    .font(.maintext2m)
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
                            PostButton(
                                title: "저장",
                                backgroundColor: .main,
                                cornerColor: .mainDarken,
                                action: {
                                    if (changeMyInfoVM.introduce.count <= introduceTextLimit) {
                                        changeMyInfoVM.changeMyInfo()
                                    } else {
                                        alertMessage = "소개 글자수는 100자 이하입니다."
                                        showAlert = true
                                    }
                                }
                            )
                            
                            Spacer()
                            NavigationLink(destination: DeleteAccount(goSignView: $goBack)) {
                                Text("계정 삭제")
                                    .foregroundColor(.black)
                                    .font(.maintext1b)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.error)
                                    .cornerRadius(37)
                                    .padding(2)
                                    .background(Color.redDarken)
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

struct EditInfo_Previews: PreviewProvider {
    static var previews: some View {
        EditInfo()
    }
}
