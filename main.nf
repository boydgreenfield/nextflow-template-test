process generateOut1 {
    output:
    path 'result*', emit: res
    path '*.json', emit: json

    """
    sleep 60
    echo '{"message": "This is my output"}' >> result.json
    """
}

process generateOut2 {
    input:
    val inp

    output:
    path '*.txt', emit: txt

    """
    sleep 60
    date > date.txt
    echo "${inp}" > date.txt
    """
}


process generateOut3 {
    input:
    val str

    output:
    path 'final.txt', emit: last

    """
    sleep 60
    echo "That's the last output, ${str}" > final.txt
    """
}

workflow {
    generateOut1()
    generateOut1.out.res.view { "Output from 1 (${it.name}): ${it.text}" }
    generateOut2(generateOut1.out.res)
    generateOut2.out.txt.view { "Output from 2 (${it.name}): ${it.text}" }
    generateOut3(generateOut2.out.txt)
    generateOut3.out.last.view { "Output from 3 (${it.name}): ${it.text}" }
}
