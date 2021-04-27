# Takeback-HFS-Template

<img src="http://rejetto.com/forum/index.php?action=dlattach;topic=13287.0;attach=9898;image" />

A modern file-sharing template for [HTTP File Server (HFS)](https://www.rejetto.com/hfs/), with a layout style of Throwback Template.

Also, use it in [HFS 2.4 RC](https://github.com/rejetto/hfs2/releases)

See its [website](https://naitlee.github.io/Takeback-HFS-Template/) or [topic](http://rejetto.com/forum/index.php?topic=13287.0) for introductions.

## Developers Notes

This template is parted into several files, inside the "parts" folder.

This is for ease of management. Also, for the use of TypeScript.

Build this template with [Super-Tpl](https://github.com/NaitLee/Super-Tpl), by selecting all files in "parts" folder.

Make a generator by replacing `@template@` with built template in file `generator-template.html`. Be sure don't leave indents before lines!

Translations are keeped in `generator-template.html`. Feel free to translate this template to your language!

And, there's a python3 file `release.py` for quick release to a zip.

====

My principle is, a template should be learnt by others, just like other open-source projects.

This way, everything can keep alive.
