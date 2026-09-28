# Contributing

Issues and pull requests are welcome.

## Try a change

```bash
sddm-greeter-qt6 --test-mode --theme "$PWD"
```

Test mode reads the real user list, so you will see your own name and avatar.

## Things that bite

- **`Themes/*.conf` values are strings.** Booleans are compared as `"true"`, not `true`.
- **Keep both configs in sync.** A new key goes into `en.conf` and `tr.conf`; CI checks that they have the same keys.
- **Regex over config files in a Turkish locale.** `[A-Za-z]` does not match `i` under `tr_TR`; run `sed` with `LC_ALL=C`.
- **The avatar comes from SDDM's `icon` role**, which is already a `file://` URL in SDDM 0.21. Do not prefix it twice.
- **The username field stays in the tree.** It is read-only and shows the preselected user; removing it breaks `triggerLogin()`.

Run `shellcheck install.sh` before sending changes to the installer.
