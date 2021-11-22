#!/bin/sh
# properties = {"type": "single", "rule": "segment", "local": false, "input": ["output/output_genome2/alignments/aligned_sim_transloc_reads40d188dd-1dc4-4da6-a0c4-741468836f2a_nreads12000_sizedels1000.bam"], "output": ["output/output_genome2/plots_segmented/plotCN_40d188dd-1dc4-4da6-a0c4-741468836f2a_nreads12000_sizedels1000_binsize002_ACE08cellularity.pdf"], "wildcards": {"genome": "genome2", "name": "40d188dd-1dc4-4da6-a0c4-741468836f2a", "nreads": "12000", "size_deletion": "1000", "binsize": "002"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 181, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/plots_segmented/plotCN_40d188dd-1dc4-4da6-a0c4-741468836f2a_nreads12000_sizedels1000_binsize002_ACE08cellularity.pdf --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.o3pmtwcu output/output_genome2/alignments/aligned_sim_transloc_reads40d188dd-1dc4-4da6-a0c4-741468836f2a_nreads12000_sizedels1000.bam --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules segment --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.o3pmtwcu/181.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.o3pmtwcu/181.jobfailed; exit 1)

