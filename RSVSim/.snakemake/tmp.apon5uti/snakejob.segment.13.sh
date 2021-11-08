#!/bin/sh
# properties = {"type": "single", "rule": "segment", "local": false, "input": ["output/output_genome2/alignments/aligned_sim_transloc_reads332c10de-130b-4df7-83cf-9c80004546b2_nreads12000_sizedels500.bam"], "output": ["output/output_genome2/plots_segmented/plotCN_332c10de-130b-4df7-83cf-9c80004546b2_nreads12000_sizedels500.pdf"], "wildcards": {"genome": "genome2", "name": "332c10de-130b-4df7-83cf-9c80004546b2", "nreads": "12000", "size_deletion": "500"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 13, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/plots_segmented/plotCN_332c10de-130b-4df7-83cf-9c80004546b2_nreads12000_sizedels500.pdf --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.apon5uti output/output_genome2/alignments/aligned_sim_transloc_reads332c10de-130b-4df7-83cf-9c80004546b2_nreads12000_sizedels500.bam --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules segment --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.apon5uti/13.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.apon5uti/13.jobfailed; exit 1)

