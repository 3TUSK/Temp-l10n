# Contributing Guideline

(I should have written a Chinese version.)

## If you are going to reporting an error
As a volunteer work, all contributers won't work here all the time, so other people's suggestions will be helpful, even vital.  
If you need report an translation error here, just remember:

 1. Start your issue ticket title with `[Mod name]`
 2. It is recommended to use English; while Chinese is still suppoted de facto.
 3. Directly point the questioning line(s).

## If you are going to open a pull request

### Before
Please read [this guideline](https://github.com/Meow-J/Mod-Translation-Styleguide) on any of our translations. All files submitted here must follow this guideline.

### Seting up
If you want to put a language file here:

1. Check out the assets folder, and set up a new folder with appropriate name. E.g.: `assets\alchemicalwizardy\lang\` for Blood Magic.

2. If possible, upload the English language file `en_US.lang` and rename it as `en_US.reference`. This is not mandatory, but we still recommended to do so where possible.

Or, if you just want to make some correction(s): nothing need to say, go ahead to edit the file. Don't mess up anything else.

### Translation
*There are three difficulties in translation: faithfulness, expressiveness, and elegance.* - [Yan Fu](https://en.wikipedia.org/wiki/Yan_Fu)

As such, be aware of ugly translation. We are aiming to keep high quality.  

Other things need to pay attention:
 * Full-width punctuations are mandatory.
 * Diction must reflect the original meaning; that being said, you may choose rewrite the sentence when it's *appropriate* and *necessary*.
 * We are named as "Temporary Localization". As such, we need try our best to do *localization* where possible. E.g. translating "When in Rome, do as the Romans do" to “入乡随俗”.
 * Romanized Japanese need to be translated, or at least keep the kana/kanji form. 

Also, don't touch `pack.mcmeta` unless you know *what you are doing*.
