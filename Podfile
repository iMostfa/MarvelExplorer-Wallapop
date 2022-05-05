# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MarvelExplorer' do

  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MarvelExplorer
    pod 'SVProgressHUD'
    pod 'SnapKit'


  target 'MarvelExplorerTests' do
  #  inherit! :search_paths
    # Pods for testing
  end

  target 'MarvelExplorerUI' do
    pod 'SnapKit'
    pod 'SVProgressHUD'

    plugin 'cocoapods-keys', {
      :project => "MarvelExplorer",
      :keys => [
      "marvelPublicKey",
      "marvelPrivateKey",
      ]}
  end
  
  target 'MarvelExplorerData' do
    plugin 'cocoapods-keys', {
      :project => "MarvelExplorer",
      :keys => [
      "marvelPublicKey",
      "marvelPrivateKey",
      ]}
  end
  
  plugin 'cocoapods-keys', {
    :project => "MarvelExplorer",
    :keys => [
    "marvelPublicKey",
    "marvelPrivateKey",
    ]}
  
end
