#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/e1613532-75c4-4b60-94cd-1782dbeba295"], "output": ["output/output_genome2/reads/sim_transloc_readse1613532-75c4-4b60-94cd-1782dbeba295_nreads4000_sizedels1000.fa"], "wildcards": {"genome": "genome2", "name": "e1613532-75c4-4b60-94cd-1782dbeba295", "nreads": "4000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 84, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_readse1613532-75c4-4b60-94cd-1782dbeba295_nreads4000_sizedels1000.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.qyhp3tg0 exposures/e1613532-75c4-4b60-94cd-1782dbeba295 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.qyhp3tg0/84.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.qyhp3tg0/84.jobfailed; exit 1)

