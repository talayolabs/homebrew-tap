# talayolabs Homebrew tap

```
brew install talayolabs/tap/sessionboxer
brew install talayolabs/tap/sonycam
```

Formulae live in `Formula/`. Homebrew resolves `talayolabs/tap` to this repo
(`homebrew-tap`) automatically — no registry or account involved.

## sessionboxer

Coding agents (Claude Code, Codex, Cursor, Devin) in Docker boxes, driven
from a browser: https://sessionboxer.talayolabs.com

Installs the npm tarball of the GitHub Release with Homebrew's `node`; a
Docker engine has to be installed separately. Then `sessionboxer serve`.

New Sessionboxer version: change `url` and `sha256` in
`Formula/sessionboxer.rb` to the new release's `sessionboxer-<version>.tgz`
(`shasum -a 256` of the downloaded file).

## sonycam

CLI + daemon for controlling Sony cameras: https://github.com/talayolabs/sonycam

The default install builds from source with the fake camera backend only
(Sony's Camera Remote SDK is license-gated and cannot be redistributed).
To drive a real camera:

```
SONY_SDK_DIR=/path/to/CrSDK brew reinstall --build-from-source sonycam
```
