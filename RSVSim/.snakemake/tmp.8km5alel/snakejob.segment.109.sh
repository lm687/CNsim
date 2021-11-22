#!/bin/sh
# properties = {"type": "single", "rule": "segment", "local": false, "input": ["output/output_genome2/alignments/aligned_sim_transloc_reads43a95259-a06e-42ec-b809-ecdcd5f773b1_nreads4000_sizedels1000.bam"], "output": ["output/output_genome2/plots_segmented/plotCN_43a95259-a06e-42ec-b809-ecdcd5f773b1_nreads4000_sizedels1000_binsize02_ACE08cellularity.pdf"], "wildcards": {"genome": "genome2", "name": "43a95259-a06e-42ec-b809-ecdcd5f773b1", "nreads": "4000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 109, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/plots_segmented/plotCN_43a95259-a06e-42ec-b809-ecdcd5f773b1_nreads4000_sizedels1000_binsize02_ACE08cellularity.pdf --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.8km5alel output/output_genome2/alignments/aligned_sim_transloc_reads43a95259-a06e-42ec-b809-ecdcd5f773b1_nreads4000_sizedels1000.bam --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules segment --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.8km5alel/109.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.8km5alel/109.jobfailed; exit 1)

