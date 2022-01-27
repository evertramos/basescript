# Base Scripts 📡 | Work in progress 🚧

Some handy scripts to make your life easier. 

## Video tutorials | Work in progress 🚧

Oh yeah! We **will** have some handy tips in our channel on [Youtube](https://www.youtube.com/channel/UCN5wb0eA3ZLlvJNYo23qBRQ)

[![youtube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCN5wb0eA3ZLlvJNYo23qBRQ)

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

## Function responses

All function's responses will be in capital letter and the most commom 'rule' will be to remove the wildcard word from
the response, such as 'check', 'get' and 'put'. 

#### Check functions

Responses will be the function's name without the word 'check': 

```bash
docker_check_container_is_running()
{
    [...]
    DOCKER_CONTAINER_IS_RUNNING=true
}
```

#### Confirm functions

Responses will be the function's name without the word 'confirm' and '_RESPONSE' at the end of the string:

```bash
confirm_user_action()
{
    [...]
    USER_ACTION_RESPONSE=true
}
```

> This was one of the first functions we created so, we will try to keep it simple next functions, but must keep that for 
> compatibility purposes




***** GET FUNCTIONS AS WELL 

ip_get_external_ipv4 example returns IP_EXTERNAL_IPV4

## Versioning

Every change should be non breakable, if it worked for you in some *main version* it should continue to work in all corrections and new functions.

Versioning: v**X.Y**

'X': main version

'Y': corrections / new functions

## Documentation

There will be a specific page for documentation and samples of every function in this repo.

Please check

[Docs](docs/README.md)

## Security Vulnerability ✋

If you find any security vulnerability, please DO NOT open an issue, send an email to [evert.ramos@gmail.com](mailto:evert.ramos@gmail.com).

### Shebang 

- All scripts were desgined to run in bash. Hum... right, You might ask about _shebang_... yes I used absolute path in all scripts '/bin/bash'. Yes, there is discussions on that matter, but if you don't have bash, you probably know some tricks to update all files at once, right? If not I will provide you a way to do that, if you have _sed_ at least.

# Support this project at [Patreon](https://www.patreon.com/evertramos)
[https://www.patreon.com/evertramos](https://www.patreon.com/evertramos)

