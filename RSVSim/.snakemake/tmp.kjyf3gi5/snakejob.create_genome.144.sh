#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/d727e4ce-de2c-4b2c-9f88-9dbc3027542d"], "output": ["output/output_genome2/reads/sim_transloc_readsd727e4ce-de2c-4b2c-9f88-9dbc3027542d_nreads12000_sizedels200.fa"], "wildcards": {"genome": "genome2", "name": "d727e4ce-de2c-4b2c-9f88-9dbc3027542d", "nreads": "12000", "size_deletion": "200"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 144, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_readsd727e4ce-de2c-4b2c-9f88-9dbc3027542d_nreads12000_sizedels200.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.kjyf3gi5 exposures/d727e4ce-de2c-4b2c-9f88-9dbc3027542d --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.kjyf3gi5/144.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.kjyf3gi5/144.jobfailed; exit 1)

