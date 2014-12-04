[![License GPL 3][badge-license]](http://www.gnu.org/licenses/gpl-3.0.txt)
[![Build Status](https://travis-ci.org/tonini/alchemist.el.png)](https://travis-ci.org/tonini/alchemist.el)
[![MELPA](http://melpa.org/packages/alchemist-badge.svg)](http://melpa.org/#/alchemist)
[![MELPA Stable](http://stable.melpa.org/packages/alchemist-badge.svg)](http://stable.melpa.org/#/alchemist)

<br/>

<p align="center">
  <img
  src="https://raw.githubusercontent.com/tonini/alchemist.el/master/logo/alchemist_logo.png"
  alt="Alchemist Logo"/>
</p>

<p align="center">
  <blockquote>Elixir Tooling Integration Into Emacs</blockquote>
</p>

***

- [Installation](#installation)
  - [ELPA](#installation-via-packageel)
  - [Via el-get](#via-el-get)
  - [Manual](#manual)
- [Configuration](#configuration)
- [Mix](#mix)
- [Compile & Execute](#compile-and-execute)
  - [Compile](#compile-functions)
  - [Execute](#execute-functions)
- [Documentation lookup](#documentation-lookup)
- [Keymap](#alchemist-help-minor-mode-keymap)
- [Auto-completion](#auto-completion)
- [Hooks](#hooks)
- [Modeline](#modeline)
- [Keymap](#keymap)
- [Contributing](#contributing)


## Installation

### Installation via package.el

`package.el` is the built-in package manager in Emacs.

Alchemist.el is available on the three major community maintained repositories -
[MELPA STABLE](melpa-stable.milkbox.net), [MELPA](http://melpa.milkbox.net) and [Marmalade](https://marmalade-repo.org/).

You can install `Alchemist` with the following commnad:

<kbd>M-x package-install [RET] alchemist [RET]</kbd>

or by adding this bit of Emacs Lisp code to your Emacs initialization file
(`.emacs` or `init.el`):

```el
(unless (package-installed-p 'alchemist)
  (package-install 'alchemist))
```

If the installation doesn't work try refreshing the package list:

<kbd>M-x package-refresh-contents [RET]</kbd>

Keep in mind that MELPA packages are built automatically from
the `master` branch, meaning bugs might creep in there from time to
time. Never-the-less, installing from MELPA is the recommended way of
obtaining Alchemist, as the `master` branch is normally quite stable and
"stable" (tagged) builds are released somewhat infrequently.

With the most recent builds of Emacs, you can pin Alchemist to always
use MELPA Stable by adding this to your Emacs initialization:

```el
(add-to-list 'package-pinned-packages '(alchemist . "melpa-stable") t)
```

### Via el-get

[el-get](https://github.com/dimitri/el-get) is another popular package manager for Emacs. If you're an el-get
user just do <kbd>M-x el-get-install [RET] alchemist [RET]</kbd>.

### Manual

You can install Alchemist manually by placing Alchemist on your `load-path` and
`require` ing it. Many people favour the folder `~/.emacs.d/vendor`.

```el
(add-to-list 'load-path "~/.emacs.d/vendor/alchemist.el/")
(require 'alchemist)
```

## Configuration

There are some ways Alchemist can be adjusted that certain workflows operating differently.

Enable ansi color formatted documentation:

```el
(setq alchemist-help-docs-ansi-color-enabled t) ;; default: nil
```

Disable complete and documention lookup for project own codebase:

```el
(setq alchemist-project-codebase-complete-and-docs-enabled t) ;; default nil
```

To get code completion and documentation lookup for the current codebase,
the project needs to be compiled. With the variable above
`alchemist-project-codebase-complete-and-docs-enabled` it can be enabled. By
default it's set to `nil` and the code completion and documention lookup will
just work with the Elixir language core and standart libraries.

The function `alchemist-project-toggle-complete-and-docs` can also be used to enable/disable
completion and documentation when needed.

### Project configuration file

To setup custom configurations for different Elixir projects, create a
`.alchemist` file in the root of the project.

Example:

```json
{
  "docs-ansi-color-enabled": "t",
  "codebase-complete-and-docs-enabled": "t"
}
```

## Mix

<table>
    <tr>
        <th>Command (For the <code>M-x</code> prompt.)</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>alchemist-mix-new</code></td>
        <td>Create a new Elixir application.</td>
    </tr>
     <tr>
        <td><code>alchemist-mix-test</code></td>
        <td>Run the whole Elixir application test suite.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-test-this-buffer</code></td>
        <td>Run the current buffer through <code>mix test</code> command.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-test-file</code></td>
        <td>Run a file through <code>mix test</code> command.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-test-at-point</code></td>
        <td>Run the test at point.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-compile</code></td>
        <td>Compile the whole Elixir application.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-run</code></td>
        <td>Runs the given expression in the Elixir application context.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-deps-with-prompt</code></td>
        <td>Prompt for <code>mix deps</code> commands.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-local-with-prompt</code></td>
        <td>Prompt for <code>mix local</code> commands.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-local-install</code></td>
        <td>Prompt for <code>mix local.install</code> PATH or URL.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-local-install-with-path</code></td>
        <td>Runs <code>mix local.install</code> and prompt for a PATH as argument.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-local-install-with-url</code></td>
        <td>Runs <code>mix local.install</code> and prompt for a URL as argument.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-help</code></td>
        <td>Show help output for a specific mix command.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-execute</code></td>
        <td>Run any command in the context of the application.</td>
    </tr>
    <tr>
        <td><code>alchemist-mix-hex-search</code></td>
        <td>Display packages matching the given search query.</td>
    </tr>
</table>


## Compile And Execute

### Compile functions

<table>
    <tr>
        <th>Command (For the <code>M-x</code> prompt.)</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>alchemist-compile-this-buffer</code></td>
        <td>Compile the current buffer with <code>elixirc</code>.</td>
    </tr>
    <tr>
        <td><code>alchemist-compile-file</code></td>
        <td>Compile the given <code>FILENAME</code>.</td>
    </tr>
    <tr>
        <td><code>alchemist-compile</code></td>
        <td>Run a custom compile command with <code>elixirc</code>.</td>
    </tr>
</table>

### Execute functions

<table>
    <tr>
      <th>Command (For the <code>M-x</code> prompt.)</th>
      <th>Description</th>
    </tr>
    <tr>
      <td><code>alchemist-execute-this-buffer</code></td>
      <td>Run the current buffer through <code>elixir</code>.</th>
    </tr>
    <tr>
      <td><code>alchemist-execute-file</code></th>
      <td>Run <code>elixir</code> with the given <code>FILENAME</code>.</th>
    </tr>
    <tr>
      <td><code>alchemist-execute</code></th>
      <td>Run a custom execute command with <code>elixir</code>.</th>
    </tr>
</table>

## Documentation lookup

There is the `alchemist-help-minor-mode` for a complete fully functional
interface to the Elixir documentation. The `alchemist-help-minor-mode` uses the
same functions like Elixir's [IEx](http://elixir-lang.org/docs/stable/iex/).

What does that mean? It means no matter which Elixir version is currently
installed on the system, the documentation you get by `alchemist` is the same
`IEx` would deliver.

By default the ANSI color formated documentation is disabled. You can enable it
by setting the following variable to `t`.

```el
(setq alchemist-help-docs-ansi-color-enabled t)
```

<table>
    <tr>
        <th>Command (For the <code>M-x</code> prompt.)</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>alchemist-help</code></td>
        <td>Run a custom search.</td>
    </tr>
    <tr>
        <td><code>alchemist-help-history</code></td>
        <td>Toggle through search history.</td>
    </tr>
    <tr>
        <td><code>alchemist-help-search-at-point</code></td>
        <td>Run <code>alchemist-help</code> with the expression under the
    cursor. (example: <code>is_binary</code> or <code>Code.eval_string</code>)</td>
    </tr>
    <tr>
        <td><code>alchemist-help-search-marked-region</code></td>
        <td>Run <code>alchemist-help</code> with the current marked region.</td>
    </tr>
</table>

### Alchemist Help Minor Mode Keymap

Inside of the `alchemist-help-minor-mode` (`*elixir help*` buffer) the key `?` will
open a keymap summary in the `minibuffer` with the following functionality:

You're always be able to continue to search inside the `*elixir help*` buffer.

![Alchemist Help Minor Mode Key Summary](https://raw.githubusercontent.com/tonini/alchemist.el/master/logo/help_summary.png)

<table>
    <tr>
        <th>Key</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>q</code></td>
        <td>Quit <code>*elixir help*</code> buffer window</td>
    </tr>
    <tr>
        <td><code>e</code></td>
        <td><code>alchemist-help-search-at-point</code></td>
    </tr>
    <tr>
        <td><code>m</code></td>
        <td><code>alchemist-help-search-marked-region</code></td>
    </tr>
    <tr>
        <td><code>s</code></td>
        <td><code>alchemist-help</code></td>
    </tr>
    <tr>
        <td><code>n</code></td>
        <td><code>alchemist-help-next-search</code></td>
    </tr>
    <tr>
        <td><code>p</code></td>
        <td><code>alchemist-help-previous-search</code></td>
    </tr>
    <tr>
        <td><code>?</code></td>
        <td><code>alchemist-help-minor-mode-key-binding-summary</code></td>
    </tr>
</table>

## Auto-completion

Alchemist users are advised to use
[company-mode](http://company-mode.github.io/) to enable auto-completion inside
of Elixir source code.

Alchemist enables a company-mode elixir backend by default if company-mode is
installed.

![Alchemist Company](logo/alchemist-company.gif)

## Hooks

There is a `after-save-hook` called `alchemist-hooks--test-on-save` which runs
the whole elixir test suite via `alchemist-mix-test`. The `alchemist-mix-test`
will just run if the current buffer is in major `elixir-mode`.

If you would like to use it just set the `alchemist-hooks-test-on-save` variable
via `(setq alchemist-hooks-test-on-save t)` or `M-x customize-group [RET] alchemist-hooks`

## Modeline

By default the status of `alchemist-mix-test`, `alchemist-compile` etc will be
represented via the colorized `mode-name`. In our case that will be the `elixir-mode`.

If you don't like that just set the `alchemist-buffer-status-modeline` variable
via `(setq alchemist-buffer-status-modeline nil)` or `M-x customize-group [RET] alchemist-buffer`

![Alchemist Build Status](https://raw.githubusercontent.com/tonini/alchemist.el/master/logo/build_status.png)

## Keymap

Alchemist comes with a default keymap.

You find and overview of all the key-bindings on the [Alchemist-Refcard](https://github.com/tonini/alchemist.el/blob/master/doc/alchemist-refcard.pdf?raw=true).

## Contributing

Contributions are very welcome!

1. Fork alchemist.el
2. Create a topic branch - `git checkout -b my_branch`
4. Push to your branch - `git push origin my_branch`
5. Send me a pull-request for your topic branch
6. That's it!

## License

Copyright © 2014 Samuel Tonini and
[contributors](https://github.com/tonini/alchemist.el/contributors).

Distributed under the GNU General Public License, version 3

[badge-license]: https://img.shields.io/badge/license-GPL_3-green.svg
