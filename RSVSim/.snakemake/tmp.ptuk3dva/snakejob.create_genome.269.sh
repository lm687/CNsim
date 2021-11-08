#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/b633c91e-92cf-412d-b237-42f0bc10055f"], "output": ["output/output_genome2/reads/sim_transloc_readsb633c91e-92cf-412d-b237-42f0bc10055f.fa"], "wildcards": {"genome": "genome2", "name": "b633c91e-92cf-412d-b237-42f0bc10055f"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 269, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsb633c91e-92cf-412d-b237-42f0bc10055f.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/b633c91e-92cf-412d-b237-42f0bc10055f --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/269.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/269.jobfailed; exit 1)

