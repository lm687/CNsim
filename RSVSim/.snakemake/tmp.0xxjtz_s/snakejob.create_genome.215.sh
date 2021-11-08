#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/fce46f10-e850-4f42-a284-7aa2b315bed2"], "output": ["output/output_genome2/reads/sim_transloc_readsfce46f10-e850-4f42-a284-7aa2b315bed2.fa"], "wildcards": {"genome": "genome2", "name": "fce46f10-e850-4f42-a284-7aa2b315bed2"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 215, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsfce46f10-e850-4f42-a284-7aa2b315bed2.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s exposures/fce46f10-e850-4f42-a284-7aa2b315bed2 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/215.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/215.jobfailed; exit 1)

