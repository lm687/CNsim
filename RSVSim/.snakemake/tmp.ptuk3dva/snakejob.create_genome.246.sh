#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/ae6dac2e-4d87-4dc8-b9a1-10a95915907f"], "output": ["output/output_genome2/reads/sim_transloc_readsae6dac2e-4d87-4dc8-b9a1-10a95915907f.fa"], "wildcards": {"genome": "genome2", "name": "ae6dac2e-4d87-4dc8-b9a1-10a95915907f"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 246, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsae6dac2e-4d87-4dc8-b9a1-10a95915907f.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/ae6dac2e-4d87-4dc8-b9a1-10a95915907f --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/246.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/246.jobfailed; exit 1)

