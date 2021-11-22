#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/dab9a151-3f5a-4617-b288-c42db54e6d42"], "output": ["output/output_genome2/reads/sim_transloc_readsdab9a151-3f5a-4617-b288-c42db54e6d42_nreads12000_sizedels1000.fa"], "wildcards": {"genome": "genome2", "name": "dab9a151-3f5a-4617-b288-c42db54e6d42", "nreads": "12000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 33, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_readsdab9a151-3f5a-4617-b288-c42db54e6d42_nreads12000_sizedels1000.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.gwn_i676 exposures/dab9a151-3f5a-4617-b288-c42db54e6d42 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.gwn_i676/33.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.gwn_i676/33.jobfailed; exit 1)

