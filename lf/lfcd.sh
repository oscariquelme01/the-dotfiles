# Change working dir in shell to last dir in lf on exit (adapted from ranger).
lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lfub -print-last-dir "$@")"
}
