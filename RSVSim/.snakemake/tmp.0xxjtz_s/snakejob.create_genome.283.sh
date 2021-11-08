#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/f9ab5a04-8e3f-40b1-957f-ff9957d907e6"], "output": ["output/output_genome2/reads/sim_transloc_readsf9ab5a04-8e3f-40b1-957f-ff9957d907e6.fa"], "wildcards": {"genome": "genome2", "name": "f9ab5a04-8e3f-40b1-957f-ff9957d907e6"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 283, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsf9ab5a04-8e3f-40b1-957f-ff9957d907e6.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s exposures/f9ab5a04-8e3f-40b1-957f-ff9957d907e6 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/283.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/283.jobfailed; exit 1)

