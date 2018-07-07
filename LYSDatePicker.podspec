Pod::Spec.new do |s|
s.name         = "LYSDatePicker"
s.version      = "0.0.1"
s.summary      = "I hope everyone will give me some advice during the process of use. I want to go further."
s.description  = <<-DESC
LYSDatePicker is mainly to adapt to the scenes that need to choose the date in daily development. The bottom layer is mainly implemented by UIPickerView and UIDatePicker components. Since this is just released, there may be bugs in the middle of use, so you need to ask for it, I will try to fix it.
DESC
s.homepage     = "https://github.com/LIYANGSHUAI/LYSDatePicker"

s.platform     = :ios, "8.0"
s.license      = "MIT"
s.author             = { "李阳帅" => "liyangshuai163@163.com" }

s.source       = { :git => "https://github.com/LIYANGSHUAI/LYSDatePicker.git", :tag => s.version }

s.source_files  = "LYSDatePicker", "LYSDatePicker/*.{h,m}"
end

