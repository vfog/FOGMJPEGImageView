Pod::Spec.new do |s|

  s.name         = "FOGMJPEGImageView"
  s.version      = "0.1"
  s.summary      = "UIImageView subclass dedicated to displaying a MJPEG feed."
  s.description  = <<-DESC
                   FOGMJPEGImageView is a UIImageView subclass dedicated to displaying a MJPEG from a remote feed.

                   A typical use case for FOGMJPEGImageView would be displaying a live webcam feed.
                   DESC
  s.license      = "MIT"
  s.homepage     = "https://github.com/vfog/FOGMJPEGImageView"
  s.author       = "Richard C. McGuire"
  s.source       = { :git => "https://github.com/vfog/FOGMJPEGImageView.git", :tag => "0.0.1" }
  s.requires_arc = true

  s.platform     = :ios, "7.0"

  s.source_files  = "FOGMJPEGImageView/**/*.{h,m}" #".{h,m}"

end
