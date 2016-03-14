#Contributing Guideline

### Reporting an error
As a volunteer work, all contributers won't work here all the time, so other people's suggestions will be helpful, even vital.

If you need report an translation error here, just remember two thing and you will be fine:

	1.Use ````[Insert the mod official name]```` in title 

	2.It is better to use both your native language and English.


### Setting new localization file
If you want to put a language file here:

1. Check out the assets folder, and make sure that you know the *internal* name of mod(s) you're translating. The name(s) will *vary* on mod(s).

2. It is recommended to set up a new branch, name it with mod name, and use this new branch as work space.
Id est, if you want to work on translation of SFM, you may want to do these, or anything equivalent:
````
$ git clone https://github.com/3TUSK/TemporaryLocalization.git
$ git checkout -b stevefactorymanager
$ cd assets
````

3. Set up a new folder with the internal name of mod, then set up a folder named "lang" E.g.: ````assets\alchemicalwizardy\lang\```` for main part of Blood Magic. File name should obey ISO-639-1.

4. If possible, upload the English language file `en_US.lang` and rename it as `en_US.reference`. Due to the fact that en_US.lang is a part of mod itself, please check out the license before do so.

5. Once a language file gets its appropriate place and get merged, file shall be removed from this repo, unless it's backup.

### Editing, Correcting and Reviewing
*There are three difficulties in translation: faithfulness, expressiveness, and elegance.*
---Said [Yan Fu](https://en.wikipedia.org/wiki/Yan_Fu) during translating *Evolution and Ethics* by Huxley

That is the main guideline for maintaing this repo. A simple version is below:

    1.Accurate, it is NECESSARY
    
    2.Readable, or in another word, "understandable"
    
    3.Beautiful, if possible

Oh, and don't touch ````pack.mcmeta```` unless you know *what you are doing*.

