#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/e90cfb71-693e-4a22-9c77-3f21851a7f75"], "output": ["output/output_genome2/reads/sim_transloc_readse90cfb71-693e-4a22-9c77-3f21851a7f75.fa"], "wildcards": {"genome": "genome2", "name": "e90cfb71-693e-4a22-9c77-3f21851a7f75"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 253, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readse90cfb71-693e-4a22-9c77-3f21851a7f75.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s exposures/e90cfb71-693e-4a22-9c77-3f21851a7f75 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/253.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/253.jobfailed; exit 1)

