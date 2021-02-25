# Base Scripts 

Some handy scripts to make your life easier. 

> All scripts were desgined to run in bash. Hum... right, I might know what you think, shebang... yes I used absolute path in all scripts, '/bin/bash'. Yes there is few discussions on that, but if you plan to use it in some other settings and know a fex tricks in bash you will be able to update it to wherever your bash is. Sorry if it does not apply to you... 

## Thoughts

The scripts was designed thinking of a few baselines:

- Simplicity
- Reusability
- Meaningful reading

and the Unix concept of DOTADIW:
- Do One Thing And Do It Well

## Naming functions

We designed a standard way for naming functions, which should start the function with the folder name, so, if the script
is under the './domain' folder the function will start with 'domain_'. We try to be as much verbose as possible for better
understanding "the function function".

## Versioning

Every change should be non breakable, if it worked for you in some *main version* it should continue to work in all corrections and new functions.

Versioning: v**X.Y**

'X': main version

'Y': corrections / new functions

## Documentation

There will be a specific page for documentation and samples of every function in this repo.

Please check

[Docs](docs/README.md)
