keytao_folder="../KeyTao/rime"
keytao_filenames="keytao.single.dict
keytao.supplement.dict
keytao.css.dict
keytao.phrase.dict"
xxxk_folder="../xxxk/home/mb/xkjd6"
xxxk_filenames="xkjd6_arg
xkjd6_dict_ci
xkjd6_dict_jm"
output_folder="../TempDict"

mkdir -p "${out_folder}"

for filename in ${keytao_filenames}; do

    awk -vFS="\t" -vOFS=" " -vORS="\r\n" \
        '{ if (NF==2||NF==3) {print $2,$1} }' \
        "${keytao_folder}/${filename}.yaml" \
    > "${output_folder}/${filename}_utf8.txt"

    iconv -f UTF-8 -t GB18030 "${output_folder}/${filename}_utf8.txt" > "${output_folder}/${filename}.txt"

done

awk -vORS="\r\n" \
    '{ if ($0=="[DATA]") {printf "[DATA]\n"; exit} else {print $0} }' \
    "${xxxk_folder}/xkjd6_arg.txt" \
> "${output_folder}/xkjd6_arg_header.txt"

cat "${output_folder}/xkjd6_arg_header.txt" "${output_folder}/keytao.single.dict.txt" \
> "${output_folder}/xkjd6_arg.txt"

mv "${output_folder}/keytao.phrase.dict.txt" "${output_folder}/xkjd6_dict_ci.txt"

cat "${output_folder}/keytao.supplement.dict.txt" "${output_folder}/keytao.css.dict.txt" \
> "${output_folder}/xkjd6_dict_jm.txt"