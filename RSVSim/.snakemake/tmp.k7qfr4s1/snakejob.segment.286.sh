#!/bin/sh
# properties = {"type": "single", "rule": "segment", "local": false, "input": ["output/output_genome2/alignments/aligned_sim_transloc_reads1c8b7242-17d3-4be8-8d36-fb6b59c0945c_nreads800_sizedels1.bam"], "output": ["output/output_genome2/plots_segmented/plotCN_1c8b7242-17d3-4be8-8d36-fb6b59c0945c_nreads800_sizedels1_ACE08cellularity.pdf"], "wildcards": {"genome": "genome2", "name": "1c8b7242-17d3-4be8-8d36-fb6b59c0945c", "nreads": "800", "size_deletion": "1"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 286, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/plots_segmented/plotCN_1c8b7242-17d3-4be8-8d36-fb6b59c0945c_nreads800_sizedels1_ACE08cellularity.pdf --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1 output/output_genome2/alignments/aligned_sim_transloc_reads1c8b7242-17d3-4be8-8d36-fb6b59c0945c_nreads800_sizedels1.bam --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules segment --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1/286.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1/286.jobfailed; exit 1)
