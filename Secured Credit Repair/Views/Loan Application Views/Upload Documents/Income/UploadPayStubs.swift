//
//  ContentView.swift
//  Multiple Image Picker
//
//  Created by Kavsoft on 27/04/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

// Code is Updated For Memory Issue...

import SwiftUI

struct UploadPayStubs : View {
    @ObservedObject var loanApplicationService: LoanApplicationService
    @State var selected : [SelectedImages] = []
    @State var show = false
    @State var continueBtnActive = false
    
    var body: some View{
        ZStack{
            
            Color.black.opacity(0.07).edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Text("Pay Stubs")
                    .bold()
                    .font(.title3)
                    .padding()
                
                Text("Select one month worth of paystubs")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                
                if !self.selected.isEmpty{
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 20){
                            
                            ForEach(self.selected,id: \.self){ i in
                                
                                Image(uiImage: i.image)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Button(action: {
                    
                    self.selected.removeAll()
                    
                    self.show.toggle()
                    
                }) {
                    
                    Text("Select Image(s)")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .frame(width: UIScreen.main.bounds.width / 2)
                }
                .background(Color(red: 68 / 255, green: 159 / 255, blue: 100 / 255))
                .clipShape(Capsule())
                .padding(.top, 25)
                Button(action:{ submitImages() }) {
                    NavigationLink(destination: LoanUploadIncomeDocuments(loanApplicationService: loanApplicationService), isActive: $continueBtnActive) {EmptyView()}
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(red: 68 / 255, green: 159 / 255, blue: 100 / 255))
                        Text("Continue")
                            .font(.system(size: 21))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity, alignment: .center)
                    }
                    .frame(height: 70)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 15)
                }
              


                Spacer()
//                Button(action:{ print("tap tap..tap tap tsp tsp")}) {
//                    NavigationLink(destination: LoanUploadIncomeDocuments(loanApplicationService: loanApplicationService), isActive: $continueBtnActive)
//                    {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                .fill(Color(red: 68 / 255, green: 159 / 255, blue: 100 / 255))
//                            Text("Continue")
//                                .font(.system(size: 21))
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .frame(maxWidth:.infinity, alignment: .center)
//                        }
//                        .frame(height: 70)
//                        .padding(.horizontal, 15)
//                        .padding(.vertical, 15)
//                    }
//                    .onTapGesture {
//                        print("tap tap..tap tap tsp tsp")
//                    }
//
//                }
              
            }
            
            if self.show {
                CustomPicker(selected: self.$selected, show: self.$show)
            }
        }
    }
    
    func submitImages() {
        if selected.count >= 1 {
            //            self.disableBtn.toggle()
            var data = NSData()
            var iteration: Int = 0
            for i in selected {
                iteration += 1
                data = i.image.jpegData(compressionQuality: 0.8)! as NSData
                loanApplicationService.uploadImage(image: data as Data, fileName: Document.PayStubs, side: String(iteration))
                continueBtnActive = true
            }
        }
    }
}



struct UploadPayStubs_Previews: PreviewProvider {
    static var previews: some View {
        UploadPayStubs(loanApplicationService: LoanApplicationService())
    }
}

