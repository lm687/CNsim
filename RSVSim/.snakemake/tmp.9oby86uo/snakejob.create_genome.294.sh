#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/383580b0-b8e8-4d9a-8dc3-3ac4ff7ad2d5"], "output": ["output/output_genome2/reads/sim_transloc_reads383580b0-b8e8-4d9a-8dc3-3ac4ff7ad2d5_nreads12000_sizedels1000.fa"], "wildcards": {"genome": "genome2", "name": "383580b0-b8e8-4d9a-8dc3-3ac4ff7ad2d5", "nreads": "12000", "size_deletion": "1000"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 294, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_reads383580b0-b8e8-4d9a-8dc3-3ac4ff7ad2d5_nreads12000_sizedels1000.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9oby86uo exposures/383580b0-b8e8-4d9a-8dc3-3ac4ff7ad2d5 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9oby86uo/294.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.9oby86uo/294.jobfailed; exit 1)

