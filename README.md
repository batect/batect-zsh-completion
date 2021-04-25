# batect-zsh-completion

[![Pipeline](https://github.com/batect/batect-zsh-completion/workflows/Pipeline/badge.svg?branch=main)](https://github.com/batect/batect-zsh-completion/actions?query=workflow%3APipeline+branch%3Amain)

Shell tab completions for [Zsh](https://www.zsh.org/).

## Requirements

* [Batect](https://batect.dev) v0.67 or later in your project
* [Zsh](https://www.zsh.org/) v5.8 or later

## Installing

### With [Homebrew](http://brew.sh/)

```shell
brew install batect/batect/batect-zsh-completion
```

You'll need to restart Zsh for the change to take effect.

### With [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

Clone this repository into your plugins directory:

```shell
cd "$ZSH_CUSTOM/plugins/"
git clone https://github.com/batect/batect-zsh-completion.git batect
```

Then edit `~/.zshrc`, adding `batect` to your existing list of plugins:

```shell
plugins=(...your existing plugins... batect)
```

You'll need to restart Zsh for the change to take effect.

## How this works

In order to enable multiple projects to co-exist with different versions of Batect (and corresponding different available options), the completion script
in this repository acts as a proxy to the completion script generated by the appropriate version of Batect.

[The original RFC for shell tab completion](https://github.com/batect/batect/blob/master/rfcs/2020-03-shell-tab-completion/proposal.md) has further explanation.

## Useful references

The manual for Zsh's completion system is quite detailed and isn't a great tutorial. These articles were useful when building this:

* https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
* https://wikimatze.de/writing-zsh-completion-for-padrino/
* https://web.archive.org/web/20190411104837/http://www.linux-mag.com/id/1106/
* http://zv.github.io/a-review-of-zsh-completion-utilities

For [the testing script](.batect/test-env/complete.zsh), these served as inspiration:

* https://github.com/Valodim/zsh-capture-completion
* https://github.com/zsh-users/zsh-autosuggestions/blob/master/src/strategies/completion.zsh and https://github.com/zsh-users/zsh-autosuggestions/pull/350
