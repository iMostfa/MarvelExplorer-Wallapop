use_frameworks!


##PODS##
def svProgressHUD;  pod 'SVProgressHUD'; end
def snapKit;        pod 'SnapKit'; end
def rxSwift;        pod 'RxSwift'; end
def rxCocoa;        pod 'RxCocoa'; end
def rxCombine;        pod 'RxCombine'; end

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
  rxSwift
  rxCocoa
  rxCombine
end

target 'MarvelExplorerUI' do
  svProgressHUD
  snapKit
  cocoapodKeys
  rxSwift
  rxCocoa
  rxCombine
end


target 'MarvelExplorerTests' do
  svProgressHUD
  snapKit
  cocoapodKeys
  rxSwift
  rxCombine
  rxCocoa
end

target 'MarvelExplorerData' do
  rxSwift
  rxCocoa
  rxCombine
end

target 'MarvelExplorerDomain' do
  rxSwift
  rxCocoa
  rxCombine
end
