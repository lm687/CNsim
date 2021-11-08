#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/43a95259-a06e-42ec-b809-ecdcd5f773b1"], "output": ["output/output_genome2/reads/sim_transloc_reads43a95259-a06e-42ec-b809-ecdcd5f773b1.fa"], "wildcards": {"genome": "genome2", "name": "43a95259-a06e-42ec-b809-ecdcd5f773b1"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 239, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads43a95259-a06e-42ec-b809-ecdcd5f773b1.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/43a95259-a06e-42ec-b809-ecdcd5f773b1 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/239.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/239.jobfailed; exit 1)

