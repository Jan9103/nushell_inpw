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
- `inpw listall` (list all packages known to inpw)
- [ ] `inpw info NAME`
- `inpw update` (update the repository)
- `inpw sources edit` (edit the `inpw_sources.nuon`)

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

Run `packer install` and allow the `post-install` script to run.

`inpw` is now active in new nushell instances.


## The `inpw_sources.nuon`

This files contains a list of all repositories you want to include.

The repositories can be a URL (starting with `http`) or path to a `.nuon` [repository file](repo.md).

After editing the file (`inpw sources edit`) you have to refresh your local combined
repository file with `inpw update`.


[packer.nu]: https://github.com/jan9103/packer.nu
