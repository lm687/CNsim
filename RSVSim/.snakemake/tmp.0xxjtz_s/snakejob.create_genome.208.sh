#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/c27768e7-f0bf-4a7b-96d8-22063bea52b0"], "output": ["output/output_genome2/reads/sim_transloc_readsc27768e7-f0bf-4a7b-96d8-22063bea52b0.fa"], "wildcards": {"genome": "genome2", "name": "c27768e7-f0bf-4a7b-96d8-22063bea52b0"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 208, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsc27768e7-f0bf-4a7b-96d8-22063bea52b0.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s exposures/c27768e7-f0bf-4a7b-96d8-22063bea52b0 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/208.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.0xxjtz_s/208.jobfailed; exit 1)

