#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/dcbbe336-7493-47e1-b2df-4a9798070edd"], "output": ["output/output_genome2/reads/sim_transloc_readsdcbbe336-7493-47e1-b2df-4a9798070edd.fa"], "wildcards": {"genome": "genome2", "name": "dcbbe336-7493-47e1-b2df-4a9798070edd"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 223, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsdcbbe336-7493-47e1-b2df-4a9798070edd.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s exposures/dcbbe336-7493-47e1-b2df-4a9798070edd --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/223.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/223.jobfailed; exit 1)

