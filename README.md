<!-- LTeX: enabled=false -->
# cmp_yanky
<!-- LTeX: enabled=true -->

[cmp-source](https://github.com/hrsh7th/nvim-cmp) for yank history (clipboard
history) from [yanky.nvim](https://github.com/gbprod/yanky.nvim).

<img alt="demo image showcasing suggestion" width="70%" src="https://github.com/chrisgrieser/cmp_yanky/assets/73286100/e1e62358-63d0-4261-88ed-47bb155576d2">

## Usage

```lua
require("cmp").setup {
	sources = {
		{ name = "cmp_yanky" },
	},
}
```

## Configuration

```lua
-- default values
{
	name = "cmp_yanky",
	option = {
		-- only suggest items which match the current filetype
		onlyCurrentFiletype = false,
		-- only suggest items with a minimum length
		minLength = 3,
	},
}
```

The number of possible items to be suggested depends on the size of the
history. You can change the history size with `yanky`'s [ring.history_length
option](https://github.com/gbprod/yanky.nvim#ringhistory_length).

<!-- vale Google.FirstPerson = NO -->
## Credits
In my day job, I am a sociologist studying the social mechanisms underlying the
digital economy. For my PhD project, I investigate the governance of the app
economy and how software ecosystems manage the tension between innovation and
compatibility. If you are interested in this subject, feel free to get in touch.

I also occasionally blog about vim: [Nano Tips for Vim](https://nanotipsforvim.prose.sh)

- [Academic Website](https://chris-grieser.de/)
- [Mastodon](https://pkm.social/@pseudometa)
- [ResearchGate](https://www.researchgate.net/profile/Christopher-Grieser)
- [LinkedIn](https://www.linkedin.com/in/christopher-grieser-ba693b17a/)
