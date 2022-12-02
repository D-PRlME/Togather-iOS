import SwiftUI
import SwiftUIFlowLayout
import Kingfisher

struct EditInfoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var editInfoViewModel = EditInfoViewModel()
    @State private var goBack: Bool = false
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var showImagePicker: Bool = false
    let introduceTextLimit: Int = 100
    let positionList: [String] = ["PM", "웹 프론트엔드", "백엔드", "안드로이드", "iOS", "디자인"]
    var body: some View {
        NavigationView {
            BackgroundTapGesture {
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
                            KFImage.url(URL(string: editInfoViewModel.profileImageLink))
                                .placeholder {
                                    Circle().fill(Color.whiteElevated3)
                                        .frame(width: 48, height: 48)
                                }
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 48, height: 48)
                                .overlay(Circle().stroke().foregroundColor(.whiteElevated3))
                            PostButton(
                                title: "이미지 변경",
                                backgroundColor: .main,
                                cornerColor: .mainDarken,
                                action: {
                                    self.showImagePicker.toggle()
                                }
                            )
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(image: $editInfoViewModel.image)
                            }
                            .onChange(of: editInfoViewModel.image) { _ in
                                editInfoViewModel.updateProfileImage()
                            }
                            Spacer()
                        }
                        .padding(.top, 26)
                        // ID
                        EditInfoTextField(
                            text: $editInfoViewModel.name, placeholder: "이름"
                        )
                        .padding(.top, 12)
                        // Email
                        VStack(alignment: .leading, spacing: 0) {
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
                        // Introduce
                        EditInfoTextEditor(
                            text: $editInfoViewModel.introduce,
                            placeholder: "자기소계"
                        )
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
                                    .foregroundColor(.text)
                                    .font(.maintext2m)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(editInfoViewModel.positions.contains(index.positionTypeChange) ? Color(red: 0.925, green: 0.792, blue: 0.357) : Color(red: 0.905, green: 0.905, blue: 0.905))
                                    .cornerRadius(37)
                                    .padding(1)
                                    .background(editInfoViewModel.positions.contains(index.positionTypeChange) ? Color("YellowStroke") : Color(red: 0.153, green: 0.153, blue: 0.153, opacity: 0.15))
                                    .cornerRadius(37)
                                    .onTapGesture {
                                        if editInfoViewModel.positions.contains(index.positionTypeChange) {
                                            editInfoViewModel.positions.removeAll { $0 == index.positionTypeChange }
                                        } else {
                                            editInfoViewModel.positions.append(index.positionTypeChange)
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
                                    if editInfoViewModel.introduce.count <= introduceTextLimit {
                                        editInfoViewModel.changeMyInfo()
                                    } else {
                                        alertMessage = "소개 글자수는 100자 이하입니다."
                                        showAlert = true
                                    }
                                }
                            )
                            Spacer()
                            NavigationLink(destination: DeleteAccount(goSignView: $goBack)) {
                                Text("계정 삭제")
                                    .foregroundColor(.text)
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
                            editInfoViewModel.getMyInfo()
                        }
                    }
                    .fullScreenCover(isPresented: $goBack) {
                        NavigationView {
                            LoginView()
                        }
                    }
                    .alert("안내", isPresented: $editInfoViewModel.showingAlert) {
                        Button("확인", role: .cancel) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } message: {
                        Text("프로필을 수정하였습니다.")
                    }
                }
                .navigationBarHidden(true)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}

struct EditInfo_Previews: PreviewProvider {
    static var previews: some View {
        EditInfoView()
    }
}
