if not ($'($env.NU_PACKER_HOME)/inpw_sources.nuon' | path exists) {
	"[
		# you can add local repo-files and urls to nuon files
		# files have to have a nuon extension since inpw relies on nu's autodetection

		# example repo with a few packages
		'https://raw.githubusercontent.com/Jan9103/nushell_inpw/main/repo.nuon'

		# a codeberg mirror (with all packages on codeberg as well) of the repo above:
		#'https://codeberg.org/packer.nu/inpw/raw/branch/main/codeberg_repo.nuon'
	]"
	| save -r $'($env.NU_PACKER_HOME)/inpw_sources.nuon'
}

use inpw.nu
inpw update
