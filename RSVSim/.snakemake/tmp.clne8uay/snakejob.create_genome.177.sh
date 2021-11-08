#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/d44d0749-8297-4f81-b86c-2310792b5516"], "output": ["output/output_genome2/reads/sim_transloc_readsd44d0749-8297-4f81-b86c-2310792b5516_nreads8000_sizedels10.fa"], "wildcards": {"genome": "genome2", "name": "d44d0749-8297-4f81-b86c-2310792b5516", "nreads": "8000", "size_deletion": "10"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 177, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_readsd44d0749-8297-4f81-b86c-2310792b5516_nreads8000_sizedels10.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay exposures/d44d0749-8297-4f81-b86c-2310792b5516 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay/177.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay/177.jobfailed; exit 1)

