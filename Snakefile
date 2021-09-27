
rule all:
    input:
      expand("cached_images/image_ex{idx}.RData", idx=range(1,6))

rule analyse_simulation_TMB_multiple:
    input:
        "explanation_datasets/ex{idx}.txt"
    output:
        "cached_images/image_ex{idx}.RData"
    shell:
        "Rscript simulation_nature_reject_ex{wildcards.idx}.R"

