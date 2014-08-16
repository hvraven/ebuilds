_py()
{
    COMPREPLY=($(pycompleter "${COMP_WORDS[@]}" 2>/dev/null ))
    if [[ ${COMPREPLY[0]} == '_longopt' ]]; then
        COMPREPLY=()
        _longopt 2>/dev/null
    fi
}

complete -F _py -o nospace py
