#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/4f469e5b-9b6a-4ddd-bb99-d65d8b40e28f"], "output": ["output/output_genome2/reads/sim_transloc_reads4f469e5b-9b6a-4ddd-bb99-d65d8b40e28f_nreads12000_sizedels200.fa"], "wildcards": {"genome": "genome2", "name": "4f469e5b-9b6a-4ddd-bb99-d65d8b40e28f", "nreads": "12000", "size_deletion": "200"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 36, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_reads4f469e5b-9b6a-4ddd-bb99-d65d8b40e28f_nreads12000_sizedels200.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.7lz9hflw exposures/4f469e5b-9b6a-4ddd-bb99-d65d8b40e28f --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.7lz9hflw/36.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.7lz9hflw/36.jobfailed; exit 1)

