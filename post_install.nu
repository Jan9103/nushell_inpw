# TODO: download default repo
"[
	# you can add local repo-files and urls to nuon files
	# files have to have a nuon extension since inpw relies on nu's autodetection

	# example repo with a few packages
	'https://raw.githubusercontent.com/Jan9103/nushell_inpw/main/repo.nuon'
]"
| save -r $'($env.NU_PACKER_HOME)/inpw_sources.nuon'

use inpw.nu
inpw update
