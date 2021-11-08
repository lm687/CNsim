#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/b2608b33-e62d-41e5-ac55-74294039ea1e"], "output": ["output/output_genome2/reads/sim_transloc_readsb2608b33-e62d-41e5-ac55-74294039ea1e.fa"], "wildcards": {"genome": "genome2", "name": "b2608b33-e62d-41e5-ac55-74294039ea1e"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 237, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsb2608b33-e62d-41e5-ac55-74294039ea1e.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/b2608b33-e62d-41e5-ac55-74294039ea1e --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/237.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/237.jobfailed; exit 1)

