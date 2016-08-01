# Paylocity Automation

### Description of Framework
Set up a Ruby framework that utilizes Cucumber for BDD of automation test scenarios,
Selenium WebDriver for execution of browser actions, and Cheezy's `page-object` library
for adherence to a Page Object Model design pattern. 

This framework is set up to use the newest version of Selenium (`Selenium3.0.0.beta1).
If you wish to use another (e.g. current latest stable is 2.53), simply update the `Gemfile` to
omit the version distinction.

The use of Watir is possible, but there're at least a few areas tha may need updated 
(e.g. `navigate.to` will need changed to `goto` within `env.rb`).

### Setup
**Note**: when `/path/to/directory` is within a step, please replace that with a proper path
to the location that you locally have the object in question. Example, if object is `home.html`, and 
it is in your Home directory, please put `C:\Users\Me\home.html` instead.

1. Download [Selenium Standalone](http://selenium-release.storage.googleapis.com/3.0-beta1/selenium-server-standalone-3.0.0-beta1.jar)
1. Download [chromedriver](http://chromedriver.storage.googleapis.com/index.html?path=2.22/)
1. Add chromedriver to your path: [Windows](http://windowsitpro.com/systems-management/how-can-i-add-new-folder-my-system-path) 
[Mac/Linux](http://osxdaily.com/2014/08/14/add-new-path-to-path-command-line/)
1. Ensure that Java JDK is installed
1. Install Ruby version 2.3.1
  * For Linux and Mac, I recommend using [RVM](https://rvm.io/)
    * Once installed, execute `rvm install 2.3.1` to install latest
    * I also recommend using the command `rvm use default 2.3.1` thereafter to set as
    default version
  * For Windows, Download the [RubyInstaller](http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.3.1.exe), 
  and [DevKit(64-bit)](http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe) /
  [Devkit (32-bit)](http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe)
1. Once installed, within a Terminal/Powershell, navigate to this directory
1. Execute `gem install bundler`
1. Execute `bundle install`
1. Prior to running tests, open two new Terminals/PowerShell instances
  * In the first, run ` java -jar path/to/selenium-server-standalone-3.0.0-beta1.jar -role hub`
  * In the second, run `java -jar .\selenium-server-standalone-3.0.0-beta1.jar -role node -browser browseName=chrome,platform=windows`
1. From there, you should be able to run `cucumber SITE="path/to/paylocity/home.html"`


### Additional Notes
At least for Windows, I wasn't able to to get the Firefox driver to work well / successfully. The new `geckodriver` was
having some issues, and I didn't want to spend much time on its debugging.

If you've looked at the `Gemfile`, you may have noticed I have a forked version of `page-object`. 
Through the course of working on this coding challenge, I came across a bug in `page-object` gem, likley
due to the new Selenium3.0.0-beta1 release, as it was only released this week, which changed the bindings within ruby from
`executeScript` to `execute_script`. Eventually, I may submit a Pull Request fixing each of these instances, but I didn't
want to get on a tangent while focusing on this. You can see the commit [here](https://github.com/williara/page-object/commit/152bd734fa52f4226965b011d2707c1f2979db2f)