#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/eeea61be-7f8f-4d94-9548-a86cc84bc456"], "output": ["output/output_genome2/reads/sim_transloc_readseeea61be-7f8f-4d94-9548-a86cc84bc456.fa"], "wildcards": {"genome": "genome2", "name": "eeea61be-7f8f-4d94-9548-a86cc84bc456"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 227, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readseeea61be-7f8f-4d94-9548-a86cc84bc456.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/eeea61be-7f8f-4d94-9548-a86cc84bc456 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/227.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/227.jobfailed; exit 1)

