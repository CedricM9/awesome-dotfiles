<div align="center">
    <h1>Awesome Dotfiles</h1>
</div>

<div align="center">
    <h3>Gallery</h3>
</div>

![](/screenshots/screenshot.png)

## Contents ##
1. [Details](#details)
2. [Dependencies](#dependencies)
3. [Installation](#installation)
4. [Folder Structure](#folderStructure)
5. [Application Theming](#appTheming)
6. [Keybinds](#keybinds)
7. [Notes](#notes)

<a name="details"></a>
## Details ##
+ **Shell**: ZSH
+ **WM**: awesome
+ **Icons**: Tela
+ **Cursor**: xCursor Breeze Light
+ **Terminal**: Alacritty

<a name="dependencies"></a>
## Dependencies ##

|Dependency|Description|
|:----------:|:-------------:|
|`awesome-git`|Window manager (Git version required for non stable Titlebar Dependency|
|`feh`|Fast image viewer used as wallpaper setting utility|
|`picom-ibhagwan`|Window compositor, eliminates screen tearing and allows for cool fade effects**|
|`rofi`|Application launcher|
|`imagemagick`|**OPTIONAL BUT NEEDED IF USING A DIFFERENT BACKGROUND**, used in config to generate blurred wallpaper|

### Optional Dependencies ###
These will improve the user experience but aren't required:

|Dependency|Description|
|:----------:|:-------------:|
|`i3lock-color-git`|Will be opened when the lock icon is selected in the exit window|
|`acpi`|Battery managing cli application, used by top bar widget to determine battery status|
|`bluez` , `bluez-utils`|Bluetooth cli application, used by top bar widget to determine if bluetooth is on|
|`blueman`|Bluetooth managing application, spawns when the bluetooth top panel icon is clicked|
|`scrot`|Screenshot tool, which is mapped to the Print Screen key in keys.lua. **If you want to meet this dependency, ensure that the `~/Pictures` folder exists**, otherwise the program will save your screenshots to your home directory|
|`deepin-screenshot`|Screenshot tool that allows you to select a portion of the screen|
|`alsa-utils`|Provides kernel driven sound drivers, which the control of has been mapped to volume keys in keys.lua|
|`sddm`|Display Manager that displays the login|

### Fonts You Should Install ###
+ `Noto Sans`: System font. Used in this config as the WM font. Also used as font for firefox
+ [`MesloLGS`](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf): Terminal font, customized to work flawlessly with the zsh theme used, mentioned in the [application theming](#appTheming) section of the readme.

<a name="installation"></a>
## Installation ##
1. Ensure all [dependencies](#dependencies) are met
2. Clone this repository and place its contents into your `.config` folder
3. Define your desired default and startup applications (apps.lua), as well as network interfaces(widgets/network/init.lua)
4. Navigate to the `awesome/wallpaper` folder and place your desired wallpaper there as well as well as a blurred version. Use the convert command to Blur an image (Can be found in components/wallpaper.lua)

<a name="folderStructure"></a>
## Awesome Folder File Structure ##
In order to avoid a poorly organized `rc.lua` spanning thousands of lines, it has been split into multiple files / folders. I have taken extra care to create a logical directory structure that will hopefully allow those new to awesomewm to have an easy time navigating it.
+ `rc.lua`: The main script that runs when awesome starts. Defines theme and default applications, and selects them
+ `keys.lua`: Contains keybinds
+ `rules.lua`: Contains window rules
+ `theme.lua`: Contains theme variables (colors, sizing, font, etc)
+ `icons`: stores icons used in WM
+ `components`: Folder that contains all of the components of the WM, such as panels, volume and brightness sliders, notification pop-ups, etc
+ `configuration`: Contains theme-based config files for applications (ie rofi, picom, etc)
+ `widgets`: Stores widgets used in the functionality of the components
+ `wallpaper`: Where wallpaper and its blurred varient is generated / stored
+ [`treetile`](https://github.com/guotsuan/awesome-treetile): Contains a Repo to allow for the Treetiling Layout

<a name="appTheming"></a>
## Application Theming ##
### Neovim ###
1. Ensure the nvim folder from the repo has been copied into the `~/.config` directory
2. Install VimPlug with
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
3. Open neovim and run `:PlugInstall`
4. Exit and reopen neovim

### Zsh ###
1. Install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
2. Change the zsh theme to powerlevel10k
  + Download [this font](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf), and move it into your `/usr/share/fonts` directory
  + Install powerlevel10k with the command below:
  ```
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  ```
  + Open `~/.zshrc` with your fave text editor
  + Set `ZSH_THEME="powerlevel10k/powerlevel10k"` and save the file
3. Install Plugins (Note that the ~/.zshrc edits are already done in this repo)
  + Syntax highlighting (copy and paste the below command to install)
    ```
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    ```
    + Edit `~/.zshrc`, add `zsh-syntax-highlighting` to the plugins section
  + Autosuggestions (copy and paste the below command to install)
    ```
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ```
    + Edit `~/.zshrc`, add `zsh-autosuggestions` to the plugins section
4. Fini! Reopen the terminal to view the fruit of your labor

<a name="keybinds"></a>
## Keybinds ##
**Note that the modkey is set to be the windows / command key. If you would like to use a different modkey check out the `keys.lua` file.**
If you are new to awesomewm, note that tag refers to workspace, and client refers to window. Shown below are the **main** keybinds that most users will care about.

### Keyboard ###
+ `mod + enter`: Spawn terminal
+ `mod + d`: Spawn rofi (an application menu)
+ `mod + f`: Make client fullscreen
+ `mod + m`: Maximize client
+ `mod + n`: Minimize client
+ `mod + shift + n`: Unminimize client
+ `mod + [1-9]`: Switch to tag [1-9]
+ `mod + shift + [1-9]`: Move client to tag [1-9]
+ `mod + space`: Change the tag layout, alternating between tiled, floating, and maximized
+ `mod + [up / down / left / right / h / j / k / l]`: Change client by direction
+ `mod + Shift + [up / down / left / right / h / j / k / l]`: Move client by direction
+ `mod + Control + [up / down / left / right / h / j / k / l]`: Resize client by direction
+ `mod + Escape`: Show exit screen

### Mouse ###
+ `mod + drag with left click`: Move client
+ `mod + drag with right click`: Resize client

<a name="notes"></a>
## Notes ##
+ [Awesome API Documentation](https://awesomewm.org/apidoc/index.html)
+ This configuration is based off of [WillPower3309's](https://github.com/WillPower3309)[awesome-dotfiles](https://github.com/WillPower3309/awesome-dotfiles) and borrows most of its code
+ The Titlebars used are the [nice](https://github.com/mut-ex/awesome-wm-nice) Titlebars because they allow for color matching to a client
+ This configurations includes and makes use of the [treetile](https://github.com/guotsuan/awesome-treetile) layout in order to spawn clients to the right of the currently active client at all times
+ For the volume control widget, I modified the code from volume-widget which is a part of [awesome-wm-widgets](https://github.com/streetturtle/awesome-wm-widgets)
+ In order to close popup windows when clicked outside of them, I included [click_to_hide](https://bitbucket.org/grumph/home_config/src/master/.config/awesome/helpers/click_to_hide.lua)
