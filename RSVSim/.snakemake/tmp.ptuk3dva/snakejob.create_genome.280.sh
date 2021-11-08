#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/4867bc9e-a9ed-48fa-ace1-3d844ac669e2"], "output": ["output/output_genome2/reads/sim_transloc_reads4867bc9e-a9ed-48fa-ace1-3d844ac669e2.fa"], "wildcards": {"genome": "genome2", "name": "4867bc9e-a9ed-48fa-ace1-3d844ac669e2"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 280, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-globalDA/bin/python3.8 \
-m snakemake output/output_genome2/reads/sim_transloc_reads4867bc9e-a9ed-48fa-ace1-3d844ac669e2.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva exposures/4867bc9e-a9ed-48fa-ace1-3d844ac669e2 --latency-wait 5 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/280.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.ptuk3dva/280.jobfailed; exit 1)

