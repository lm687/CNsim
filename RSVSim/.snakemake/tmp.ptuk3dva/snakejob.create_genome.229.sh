#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/b1317ed5-3637-4030-a808-4378af9cbb70"], "output": ["output/output_genome2/reads/sim_transloc_readsb1317ed5-3637-4030-a808-4378af9cbb70.fa"], "wildcards": {"genome": "genome2", "name": "b1317ed5-3637-4030-a808-4378af9cbb70"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 229, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsb1317ed5-3637-4030-a808-4378af9cbb70.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/b1317ed5-3637-4030-a808-4378af9cbb70 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/229.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/229.jobfailed; exit 1)

