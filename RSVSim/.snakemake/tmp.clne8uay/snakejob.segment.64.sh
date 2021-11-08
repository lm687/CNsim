#!/bin/sh
# properties = {"type": "single", "rule": "segment", "local": false, "input": ["output/output_genome2/alignments/aligned_sim_transloc_readsd8b8e001-d2a6-4df9-948d-81d98ea17d9d_nreads8000_sizedels10.bam"], "output": ["output/output_genome2/plots_segmented/plotCN_d8b8e001-d2a6-4df9-948d-81d98ea17d9d_nreads8000_sizedels10_ACE08cellularity.pdf"], "wildcards": {"genome": "genome2", "name": "d8b8e001-d2a6-4df9-948d-81d98ea17d9d", "nreads": "8000", "size_deletion": "10"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 64, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/plots_segmented/plotCN_d8b8e001-d2a6-4df9-948d-81d98ea17d9d_nreads8000_sizedels10_ACE08cellularity.pdf --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay output/output_genome2/alignments/aligned_sim_transloc_readsd8b8e001-d2a6-4df9-948d-81d98ea17d9d_nreads8000_sizedels10.bam --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules segment --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay/64.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay/64.jobfailed; exit 1)

