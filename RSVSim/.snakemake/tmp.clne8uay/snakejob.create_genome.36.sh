#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/5df28185-3253-4dd7-b88f-320d4a5b87d0"], "output": ["output/output_genome2/reads/sim_transloc_reads5df28185-3253-4dd7-b88f-320d4a5b87d0_nreads8000_sizedels10.fa"], "wildcards": {"genome": "genome2", "name": "5df28185-3253-4dd7-b88f-320d4a5b87d0", "nreads": "8000", "size_deletion": "10"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 36, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_reads5df28185-3253-4dd7-b88f-320d4a5b87d0_nreads8000_sizedels10.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay exposures/5df28185-3253-4dd7-b88f-320d4a5b87d0 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay/36.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.clne8uay/36.jobfailed; exit 1)
