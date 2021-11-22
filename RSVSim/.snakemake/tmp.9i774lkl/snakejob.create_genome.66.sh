#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/d8b8e001-d2a6-4df9-948d-81d98ea17d9d"], "output": ["output/output_genome2/reads/sim_transloc_readsd8b8e001-d2a6-4df9-948d-81d98ea17d9d_nreads12000_sizedels1000.fa"], "wildcards": {"genome": "genome2", "name": "d8b8e001-d2a6-4df9-948d-81d98ea17d9d", "nreads": "12000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 66, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_readsd8b8e001-d2a6-4df9-948d-81d98ea17d9d_nreads12000_sizedels1000.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9i774lkl exposures/d8b8e001-d2a6-4df9-948d-81d98ea17d9d --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9i774lkl/66.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9i774lkl/66.jobfailed; exit 1)

