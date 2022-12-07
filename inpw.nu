# get the contents of the local package repository
def get_repo [] {
	let file = $'($env.NU_PACKER_HOME)/inpw_repo.nuon'
	if ($file | path exists) {
		open $file
	} else {
		print -e 'No local repository.'
		{packages: []}
	}
}

def packages_nuon [] { $'($nu.env-path | path dirname)/packages.nuon' }

# install a package
export def install [
	...package_name: string
] {
	print 'Loading repo..'
	let repo = (get_repo)
	print 'Finding packages..'
	let repo_entries = (
		$package_name
		| par-each {|name|
			let search_result = (
				$repo.packages
				| where name == $name
			)
			if ($search_result | length) != 1 {
				print -e $'(ansi rb)Found ($search_result | length) results for ($name) instead of 1.(ansi reset)'
				null
			} else {
				print $'Found ($name) at ($search_result.0.source).'
				$search_result.0
			}
		}
	)
	let packages_nuon = (packages_nuon)
	if null in $repo_entries {
		print -e 'Unable to proceed: at least one package has not been found.'
	} else {
		open $packages_nuon
		| upsert packages {|fc|
			$fc.packages
			| append (
				$repo_entries
				| par-each {|i|
					if ($fc.packages | where source == $i.source | length) == 0 {
						{
							source: $i.source
							as: $i.name
						}
						| merge {$i | get -i settings | default {}}
					}
				} | compact
			)
		}
		| save $packages_nuon
		packer install --yes
	}
}

# uninstall a package
export def uninstall [
	...package_names: string
] {
	let packages_nuon = (packages_nuon)
	open $packages_nuon
	| upsert packages {|fc|
		$fc.packages
		| par-each {|i|
			let parsed_package = (packer config parse package $i)
			if not $parsed_package.name in $package_names {$i}
		} | compact
	}
	| save $packages_nuon
	# TODO: remove old stuff
	packer compile
}

# search for packages
export def search [
	term: string
] {
	let repo = (get_repo)
	$repo.packages
	| where ($term in $it.tags || $term == $it.name)
	| select name description
}

# Edit the inpw_sources.nuon
export def 'sources edit' [] {
	let editor = ($env | get -i EDITOR | default nano)
	nu -c $'($editor) ($env.NU_PACKER_HOME)/inpw_sources.nuon'
}

# update the repository (NOT THE PROGRAMS)
export def update [] {
	let repo_contents = (
		open $'($env.NU_PACKER_HOME)/inpw_sources.nuon'
		| each {|i|
			if ($i | str starts-with 'http') { fetch $i
			} else { open $i }
		}
	)
	{
		packages: (
			$repo_contents | get -i packages | compact | flatten
			# TODO: remove duplicates
		)
	}
	| save $'($env.NU_PACKER_HOME)/inpw_repo.nuon'
}

# Update all installed packages
# Just an alias for `packer update`
export def upgrade [] { packer update }

# display information about a package
# - install status
# - repo details (including tags, source, etc)
# - fetch upstream meta.nuon (from source)
export def info [
	package_name: string
] { print -e 'Not yet implemented' }

# list all available packages
export def listall [] {
	get_repo
	| get -i packages
	| select name description
}
