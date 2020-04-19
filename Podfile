# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def rx_pods
    
    #pod 'RxSwift', '~> 5.0'
    #pod 'RxSwift'
    pod 'RxSwift', '5.0.1'
    pod 'RxCocoa', '5.0.1'
    
end

def rx_ext_pods
    
    pod 'RxSwiftExt', '5.2.0'
    pod 'RxOptional', '4.1.0'
    pod 'Action' , '4.0.0'
    pod 'RxDataSources', '4.0.1'

end

def network_pods

    pod 'Alamofire', '4.9.1'
    pod 'RxAlamofire', '5.1.0'

end

def all_pods 

    rx_pods
    rx_ext_pods
    network_pods

end





target 'iMobility' do

  all_pods
  
end

