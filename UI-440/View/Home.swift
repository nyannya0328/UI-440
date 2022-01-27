//
//  Home.swift
//  UI-440
//
//  Created by nyannyan0328 on 2022/01/27.
//

import SwiftUI

struct Home: View {
    @State var currentTab : Int = 1
    var body: some View {
        
        NavigationView{
          
            
            TabView(selection: $currentTab) {
                
                
                ForEach(1...6,id:\.self){index in
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        GeometryReader{proxy in
                            
                            let size = proxy.size
                            
                            
                            Image("p\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:UIScreen.main.bounds.width, height: size.height)
                                .offset(x: -proxy.frame(in: .global).minX)
                        }
                        .cornerRadius(10)
                        .padding()
                       // .frame(height:270)
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: -5, y: -5)
                        .padding(.horizontal,25)
                        .cornerRadius(10)
                        .overlay(
                        
                        
                        Image("p\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(x: -10)
                        
                        ,alignment: .bottomTrailing
                        
                        
                        )
                    
                        
                        
                        Marqueee(text: "Jacob Degrom.Aroldis Chapman.Roki Sasaki.Shohey Ohatani.CR7", font: UIFont.systemFont(ofSize: 20, weight: .regular))
                        
                        
                        
                        
                        
                    }
                    .padding()
                    .navigationTitle("MarrQueeText")
                }
                
               
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
          
        }
       
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct Marqueee : View{
    
    @State var text : String = ""
    
    var font : UIFont
    
    @State var offset : CGFloat = 0
    
    @State var storedSize : CGSize = .zero
    
    var animationSpeed : Double = 0.01
    
    
    @Environment(\.colorScheme) var scheme
    
    
    var body: some View{
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            Text(text)
                .font(Font(font))
                .offset(x: offset)
        }
        .overlay(
            
         
            
            
            HStack{
                
                let color : Color = scheme == .dark ? .black : .white
                
                LinearGradient(colors: [
                    
                    
                    color.opacity(0.7),
                    color.opacity(0.5),
                    color.opacity(0.3),
                 
                
                
                
                
                
                
                ], startPoint: .leading, endPoint: .trailing).frame(width: 20)
                
                
                Spacer()
                
                
                LinearGradient(colors: [
                    
                    
                    color.opacity(0.7),
                    color.opacity(0.5),
                    color.opacity(0.3),
                 
                
                
                
                
                
                
                ].reversed(), startPoint: .leading, endPoint: .trailing).frame(width: 20)
                
            
            }
        
        
        
        )
        .disabled(true)
        .onAppear {
            
            
            let basedText = text
            
            (1...15).forEach { _ in
                
                
                text.append(" ")
            }
            
            storedSize = textSize()
            
            text.append(basedText)
            
            
            let timing = (animationSpeed * storedSize.width)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                withAnimation(.linear(duration: timing)){
                    
                    
                    offset = -storedSize.width
                }
                
                
            }
            
            
        }
        .onReceive(Timer.publish(every: ((animationSpeed * storedSize.width) + 0.1), on: .main, in: .default).autoconnect()) { _ in
            
            
            offset = 0
                   
                withAnimation(.linear(duration: animationSpeed * storedSize.width)){
                    
                    
                    offset = -storedSize.width
                }
                
                
            
            
            
        }
    }
    
    
    func textSize()->CGSize{
        
        let attributed = [NSAttributedString.Key.font:font]
        
        let size = (text as NSString).size(withAttributes: attributed)
        
        return size
    }
}
