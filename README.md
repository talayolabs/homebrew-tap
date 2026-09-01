# talayolabs Homebrew tap

```
brew install talayolabs/tap/sonycam
```

Formulae live in `Formula/`. Homebrew resolves `talayolabs/tap` to this repo
(`homebrew-tap`) automatically — no registry or account involved.

## sonycam

CLI + daemon for controlling Sony cameras: https://github.com/talayolabs/sonycam

The default install builds from source with the fake camera backend only
(Sony's Camera Remote SDK is license-gated and cannot be redistributed).
To drive a real camera:

```
SONY_SDK_DIR=/path/to/CrSDK brew reinstall --build-from-source sonycam
```
