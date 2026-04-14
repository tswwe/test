in_folder="../KeyTao/rime"
out_folder="../TempDict"
in_filenames="keytao.single.dict
keytao.supplement.dict
keytao.css.dict
keytao.phrase.dict"

function generate_out_file() {
    local in_filepath="${1}"
    local out_filepath="${2}"

    cat "${in_filepath}" | \
        awk -vFS="\t" -vOFS=" " -vORS="\r\n" \
        '{ if (NF==2||NF==3) {print $2,$1} }' \
    > "${out_filepath}"

    echo "${out_filepath} generated."
}
mkdir -p "${out_folder}"
for in_filename in ${in_filenames}; do
    in_filepath=$(echo ${in_folder}/${in_filename}.yaml)
    if [[ ! -f "${in_filepath}" ]]; then
        echo "Some KeyTao dicts are missing."
        exit 1
    fi
    generate_out_file "${in_filepath}" "${out_folder}/${in_filename}_utf8.txt"
    iconv -f UTF-8 -t GB18030 "${out_folder}/${in_filename}_utf8.txt" > "${out_folder}/${in_filename}_gb18030.txt"
done

