#!/bin/sh
# properties = {"type": "single", "rule": "align_bwa", "local": false, "input": ["output/output_genome2/reads/sim_transloc_readsc0446a16-1896-42ba-a6c6-53fbcceb3063_nreads800_sizedels1.fa"], "output": ["output/output_genome2/alignments/aligned_sim_transloc_readsc0446a16-1896-42ba-a6c6-53fbcceb3063_nreads800_sizedels1.bam"], "wildcards": {"genome": "genome2", "name": "c0446a16-1896-42ba-a6c6-53fbcceb3063", "nreads": "800", "size_deletion": "1"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 143, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/alignments/aligned_sim_transloc_readsc0446a16-1896-42ba-a6c6-53fbcceb3063_nreads800_sizedels1.bam --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1 output/output_genome2/reads/sim_transloc_readsc0446a16-1896-42ba-a6c6-53fbcceb3063_nreads800_sizedels1.fa --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules align_bwa --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1/143.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1/143.jobfailed; exit 1)

