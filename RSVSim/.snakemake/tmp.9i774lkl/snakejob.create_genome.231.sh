#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/362c82d8-6739-4fa0-81d1-f8399f947270"], "output": ["output/output_genome2/reads/sim_transloc_reads362c82d8-6739-4fa0-81d1-f8399f947270_nreads12000_sizedels1000.fa"], "wildcards": {"genome": "genome2", "name": "362c82d8-6739-4fa0-81d1-f8399f947270", "nreads": "12000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 231, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_reads362c82d8-6739-4fa0-81d1-f8399f947270_nreads12000_sizedels1000.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9i774lkl exposures/362c82d8-6739-4fa0-81d1-f8399f947270 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9i774lkl/231.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9i774lkl/231.jobfailed; exit 1)

