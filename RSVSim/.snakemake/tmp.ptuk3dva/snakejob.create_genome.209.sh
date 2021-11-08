#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/a161a6c7-2fbd-4901-a163-9c3455d1ee59"], "output": ["output/output_genome2/reads/sim_transloc_readsa161a6c7-2fbd-4901-a163-9c3455d1ee59.fa"], "wildcards": {"genome": "genome2", "name": "a161a6c7-2fbd-4901-a163-9c3455d1ee59"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 209, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readsa161a6c7-2fbd-4901-a163-9c3455d1ee59.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/a161a6c7-2fbd-4901-a163-9c3455d1ee59 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/209.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/209.jobfailed; exit 1)

