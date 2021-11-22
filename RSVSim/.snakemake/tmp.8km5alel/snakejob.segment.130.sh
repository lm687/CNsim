#!/bin/sh
# properties = {"type": "single", "rule": "segment", "local": false, "input": ["output/output_genome2/alignments/aligned_sim_transloc_readsae6dac2e-4d87-4dc8-b9a1-10a95915907f_nreads4000_sizedels1000.bam"], "output": ["output/output_genome2/plots_segmented/plotCN_ae6dac2e-4d87-4dc8-b9a1-10a95915907f_nreads4000_sizedels1000_binsize02_ACE08cellularity.pdf"], "wildcards": {"genome": "genome2", "name": "ae6dac2e-4d87-4dc8-b9a1-10a95915907f", "nreads": "4000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 130, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/plots_segmented/plotCN_ae6dac2e-4d87-4dc8-b9a1-10a95915907f_nreads4000_sizedels1000_binsize02_ACE08cellularity.pdf --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.8km5alel output/output_genome2/alignments/aligned_sim_transloc_readsae6dac2e-4d87-4dc8-b9a1-10a95915907f_nreads4000_sizedels1000.bam --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules segment --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.8km5alel/130.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.8km5alel/130.jobfailed; exit 1)

