#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/0ce880ad-01a9-4206-89a1-dc2217b08533"], "output": ["output/output_genome2/reads/sim_transloc_reads0ce880ad-01a9-4206-89a1-dc2217b08533.fa"], "wildcards": {"genome": "genome2", "name": "0ce880ad-01a9-4206-89a1-dc2217b08533"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 216, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads0ce880ad-01a9-4206-89a1-dc2217b08533.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s exposures/0ce880ad-01a9-4206-89a1-dc2217b08533 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/216.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/216.jobfailed; exit 1)

