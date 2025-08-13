<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/2421f08e-3f18-45a7-837c-de2e59438040" />
<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/e357fda8-0a3a-4f3d-928c-f13aee950262" />
<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/210b18b4-ffd1-4fce-8502-39c5dedbd84d" />
 
 # My dotfiles for arch linux.

This is my personal repo to keep my dotfiles version controlled and be able to share it with friends. Right now they suck, but I'm working on it!

# Structure
I'm using [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles with symlinks. It basically works by taking everything within a folder
and linking those files into the parent directory.

By having a `~/dotfiles` folder just under the home directory, you can make stow link your configs directly into your $HOME, effectively unifying
all of your dotfiles into a single directory, perfect for version control.

The way I've structured my dotfiles is by having "packages" for each config, dividing them into different folders, meaning I can manage different configurations
in a modular fashion. Basic structure:

```
dotfiles/
├── bash
│   ├── .bash_aliases
│   └── .bashrc
├── cava
│   └── .config
│       └── cava
│           └── config
├── dunst
│   └── .config
│       └── dunst
│           └── dunstrc
── fuzzel
│   └── .config
│       └── fuzzel
│           ├── colors.ini
│           └── fuzzel.ini
...
```
Each program has its own folder for its configuration with the respective structure it would have in the home directory.
When you `stow` any one of these folders, it will take the contents and link them into the parent directory, which should be $HOME.

`cava/.config/cava/* -> ~/.config/cava/*`
`dunst/.config/dunst/* -> ~/.config/dunst/*`

[Brandon](https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) explains it better.

# Installation
Clone this repo in your $HOME (call it whatever you want as long as it's directly under $HOME).

Something like this: `~/dotfiles`.

Then all you have to do is `stow` any configuration you want:
```
cd ~/dotfiles
stow bash/
stow dunst/
stow fuzzel/
stow fuzzel/
stow hyprland/
stow micro/
...
```

To remove any configuration, you can `stow -D folder/`.

**Don't forget to run hellwal with your desired wallpaper in order to generate the necessary .cache files, otherwise nothing will have colors.**

###   Important
Stow will never override any existing file and only allows you to `--adopt`, which overrides the configuration in the stow directory with the external one.

There are two ways to override existing configuration with the one in this repo:

1. Delete the existing configuration and stow the one in your dotfiles folder (wouldn't recommend, especially for things like hyprland that reload config automatically)
2. Described [here](https://www.reddit.com/r/linux4noobs/comments/b5ig2h/comment/igmv8pp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button), you can `stow --adopt folder/` followed by `git restore .`
   > Stow will create a symlink and overwrite the files inside your repository and git will undo the changes and return to the original files but the symlinks will stay there.
