use_frameworks!


##PODS##
def svProgressHUD;  pod 'SVProgressHUD'; end
def snapKit;        pod 'SnapKit'; end

###CocoaPods###
def cocoapodKeys
  plugin 'cocoapods-keys', {
    :project => "MarvelExplorer",
    :keys => [
    "marvelPublicKey",
    "marvelPrivateKey",
    ]}
end

###Targets###
target 'MarvelExplorer' do
  cocoapodKeys
end

target 'MarvelExplorerUI' do
  svProgressHUD
  snapKit
  cocoapodKeys
end


target 'MarvelExplorerTests' do
  svProgressHUD
  snapKit
  cocoapodKeys
end

target 'MarvelExplorerData' do
  
end
