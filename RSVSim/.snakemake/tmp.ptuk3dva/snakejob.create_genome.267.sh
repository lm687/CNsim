#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/c17bfe6b-90b6-4651-b86f-f3974242df1d"], "output": ["output/output_genome2/reads/sim_transloc_readsc17bfe6b-90b6-4651-b86f-f3974242df1d.fa"], "wildcards": {"genome": "genome2", "name": "c17bfe6b-90b6-4651-b86f-f3974242df1d"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 267, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsc17bfe6b-90b6-4651-b86f-f3974242df1d.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/c17bfe6b-90b6-4651-b86f-f3974242df1d --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/267.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/267.jobfailed; exit 1)

