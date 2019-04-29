platform :ios, '12.0'

def rx_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
end

def networking_pods
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'SwiftyJSON'
end

def domain_pods
  pod 'ObjectMapper'
end

def ui_pods
  pod 'SnapKit'
end

target 'cityEvents' do
  use_frameworks!

  rx_pods
  networking_pods
  domain_pods
  ui_pods

end

