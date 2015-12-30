# wallpaper.sh

## Requirements
The feh and sunwait must be in the same directory as this script or accessible from your $PATH
- [feh](http://feh.finalrewind.org/) for setting the wallpaper
- [sunwait](http://sourceforge.net/projects/sunwait4windows/) for calculating sunrise/-set based on your location. You can compile it yourself or use the precompiled version from this repository.
- some sets of wallpapers like those: [nowPaper by Alex Pasquarella](https://imgur.com/a/SBxCV)

## Usage
```
wallpaper.sh, sets wallpapers depending on daytime
Usage: wallpaper.sh [latitude] [longitude] [wallpaper path]

This script requires 'feh' for setting the wallpaper and 'sunwait' to calculate sunrise/set.
They can either be somewhere in your $PATH or in the same directory as this script.

latitude/longigude are expressed in floating-point degrees, with [NESW] appended

The wallpaper directory has to contain image sets with this name structure:
[name][dawn|day|dusk|night]
example set:
 	nowPaper/
 	├── Canyondawn.png
 	├── Canyonday.png
 	├── Canyondusk.png
 	└── Canyonnight.png
If you have multiple sets of wallpapers in this directory it will cicle trough them randomly.

Options:
 -h 	Print help (this screen)
 -o 	One Shot mode (set wallpaper and exit)
 -v 	Verbose Mode

Command exapmle:
	wallpaper.sh 48.20849N 16.37208E ~/wallpapers/nowPaper
```
## Example wallpaper set
![](https://imgur.com/lrZAbFr)
