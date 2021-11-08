#!/bin/sh
# properties = {"type": "single", "rule": "segment", "local": false, "input": ["output/output_genome2/alignments/aligned_sim_transloc_reads61f41cee-25ec-46cd-bbfc-7e14c6fcce44_nreads8000_sizedels1.bam"], "output": ["output/output_genome2/plots_segmented/plotCN_61f41cee-25ec-46cd-bbfc-7e14c6fcce44_nreads8000_sizedels1_ACE08cellularity.pdf"], "wildcards": {"genome": "genome2", "name": "61f41cee-25ec-46cd-bbfc-7e14c6fcce44", "nreads": "8000", "size_deletion": "1"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 25, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/plots_segmented/plotCN_61f41cee-25ec-46cd-bbfc-7e14c6fcce44_nreads8000_sizedels1_ACE08cellularity.pdf --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.60zglamo output/output_genome2/alignments/aligned_sim_transloc_reads61f41cee-25ec-46cd-bbfc-7e14c6fcce44_nreads8000_sizedels1.bam --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules segment --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.60zglamo/25.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.60zglamo/25.jobfailed; exit 1)

