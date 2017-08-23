# drawlogo86
drawlogo86 can live in your storage's boot sector and show a (not so) fancy
16x16 picture when you boot it, nice for data (micro/mini)SDs, flash memories, floppies. similar to `mkfs.fat`'s `-m` but shows a small image instead of a text message.

Oh and let's not forget, drawlogo86 is for 80286+ processors
## Screenshot
A screenshot of it running in QEMU with my ugly picture!
![drawlogo86 running in QEMU](https://github.com/farooqkz/drawlogo86/raw/master/screenshot.png "drawlogo86 running in QEMU")
## Usage
**WARNING! There is absolutely NO WARRANTY and there is risk of losing data,
USE AT YOUR OWN RISK!**

To make it working on your storage(let's say a floppy containing your data) you
need to know what are you doing.

First of all get a copy of your data if you care about them.
You need `nasm` and `dd` if you are on Unix or `partcopy` if you are using
Windows/DOS. depending on your filesystem, you should change two last lines of
`drawlogo86.asm`. Also modify `pixels.inc` file which contains colors of
pixels, there is 256 color for each pixel and a pixel's color can be `0x00` to
`0xFF`. You should also know about the file system which you are using(e.g.
where boot code does start and where does it end?)

I repeat, you MUST know what are you doing and there is RISK OF DATA LOSE, USE
AT YOUR OWN RISK.
## Licence
This is free software under MIT/X11 and comes WITHOUT ANY WARRANTY, see LICENSE
for more details.
## Bug Report/Questings/Contribute/etc
Use Github(Issues for Bug Report and Questions and Pull Requests for
Contributing) or email me.
