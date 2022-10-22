# Interactive Nu Packer Wrapper

A command based config wrapper for [packer.nu][].

It is still possible to manually add packages to the `packages.nu`,
but you should avoid it and fully commit to inpw if you have it installed.

## Commands:

- `inpw install NAMES`
	- [ ] install things without the repo (via source)
- `inpw uninstall NAMES`
- `inpw upgrade` (update the packages)
- `inpw search TERM`
- [ ] `inpw info NAME`
- [ ] `inpw update` (update the repository)
- `inpw listall` (list all packages known to inpw)

## Installation (for now)

Install [packer.nu][] first.

Paste the following into `~/.config/nushell/packages.nuon`
```
{
	packages: [
		{source: 'jan9103/packer.nu'}
		{source: 'jan9103/nushell_inpw'}
	]
}
```

Run `packer install`

Copy a [valid repository](repo.md) to `$'($env.NU_PACKER_HOME)/inpw_repo.nuon'`
(for example the `repo.nuon` in this git repo) (in the future you will
be able to have multiple remote-repos, but for now this is how you do it).


`inpw` is now active in new nushell instances.


[packer.nu]: https://github.com/jan9103/packer.nu
