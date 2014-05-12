#
#  Be sure to run `pod spec lint FOGMJPEGImageView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "FOGMJPEGImageView"
  s.version      = "0.0.1"
  s.summary      = "UIImageView subclass dedicated to displaying a MJPEG feed."
  s.description  = <<-DESC
                   FOGMJPEGImageView is a UIImageView subclass dedicated to displaying a MJPEG from a remote feed.

                   A typical use case for FOGMJPEGImageView would be displaying a live webcam feed.
                   DESC
  s.license      = "MIT"
  s.homepage     = "https://github.com/vfog/FOGMJPEGImageView"
  s.author       = "Richard C. McGuire"
  s.source       = { :git => "https://github.com/vfog/FOGMJPEGImageView.git", :commit => "526a1aed1bd1abb3ba4b090abbfca811d48a9959" } #, :tag => "0.0.1" }
  s.requires_arc = true

  s.platform     = :ios, "7.0"

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any h, m, mm, c & cpp files. For header
  #  files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "FOGMJPEGImageView/**/*.{h,m}" #".{h,m}"

  # s.public_header_files = "Classes/**/*.h"



end
