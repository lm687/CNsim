#!/bin/sh
# properties = {"type": "single", "rule": "segment", "local": false, "input": ["output/output_genome2/alignments/aligned_sim_transloc_reads89a3b656-e4a8-405b-a786-bf31d594e525_nreads800_sizedels1.bam"], "output": ["output/output_genome2/plots_segmented/plotCN_89a3b656-e4a8-405b-a786-bf31d594e525_nreads800_sizedels1_ACE08cellularity.pdf"], "wildcards": {"genome": "genome2", "name": "89a3b656-e4a8-405b-a786-bf31d594e525", "nreads": "800", "size_deletion": "1"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 106, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/plots_segmented/plotCN_89a3b656-e4a8-405b-a786-bf31d594e525_nreads800_sizedels1_ACE08cellularity.pdf --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1 output/output_genome2/alignments/aligned_sim_transloc_reads89a3b656-e4a8-405b-a786-bf31d594e525_nreads800_sizedels1.bam --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules segment --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1/106.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1/106.jobfailed; exit 1)
