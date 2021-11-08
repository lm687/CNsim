#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/e1613532-75c4-4b60-94cd-1782dbeba295"], "output": ["output/output_genome2/reads/sim_transloc_readse1613532-75c4-4b60-94cd-1782dbeba295.fa"], "wildcards": {"genome": "genome2", "name": "e1613532-75c4-4b60-94cd-1782dbeba295"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 230, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_readse1613532-75c4-4b60-94cd-1782dbeba295.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/e1613532-75c4-4b60-94cd-1782dbeba295 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/230.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/230.jobfailed; exit 1)

