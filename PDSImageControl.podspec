Pod::Spec.new do |s|
    s.name     = 'PDSImageControl'
    s.version  = '0.0.6'
    s.summary  = 'Description of your projectx'
    s.license  = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author   = {
        'w91379137' => 'w91379137'
    }
    s.homepage = 'https://github.com/w91379137/PDSImageControl'

    s.source   = {
        :git => 'https://github.com/w91379137/PDSImageControl.git',
        :tag => s.version.to_s
    }
    s.source_files = 'PDSImageControl/**/*'
    s.requires_arc = true

    s.platform = :ios
    s.ios.deployment_target = '8.0'
end
