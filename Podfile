# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MarvelExplorer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SnapKit'
  pod 'SVProgressHUD'

  # Pods for MarvelExplorer

  target 'MarvelExplorerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MarvelExplorerUITests' do
    # Pods for testing
  end

  plugin 'cocoapods-keys', {
    :project => "MarvelExplorer",
    :keys => [
    "marvelPublicKey",
    "marvelPrivateKey",
    ]}
  
end
