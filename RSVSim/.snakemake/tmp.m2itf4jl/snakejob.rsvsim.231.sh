#!/bin/sh
# properties = {"type": "single", "rule": "rsvsim", "local": false, "input": ["exposures/sigset2/bc7e2179-b57d-45c0-842f-e18fb9a9f300"], "output": ["output/output_genome2/outputRSVSim/sigset2_40/bc7e2179-b57d-45c0-842f-e18fb9a9f300.RDS"], "wildcards": {"genome": "genome2", "sigset": "sigset2", "num_events": "40", "name": "bc7e2179-b57d-45c0-842f-e18fb9a9f300"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 231, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/outputRSVSim/sigset2_40/bc7e2179-b57d-45c0-842f-e18fb9a9f300.RDS --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m2itf4jl exposures/sigset2/bc7e2179-b57d-45c0-842f-e18fb9a9f300 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules rsvsim --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m2itf4jl/231.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m2itf4jl/231.jobfailed; exit 1)
