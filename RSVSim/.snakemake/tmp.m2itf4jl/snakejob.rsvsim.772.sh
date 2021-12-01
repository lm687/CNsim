#!/bin/sh
# properties = {"type": "single", "rule": "rsvsim", "local": false, "input": ["exposures/sigset3/3d15f518-2a92-4a86-86f6-669054fcca64"], "output": ["output/output_genome2/outputRSVSim/sigset3_40/3d15f518-2a92-4a86-86f6-669054fcca64.RDS"], "wildcards": {"genome": "genome2", "sigset": "sigset3", "num_events": "40", "name": "3d15f518-2a92-4a86-86f6-669054fcca64"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 772, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/outputRSVSim/sigset3_40/3d15f518-2a92-4a86-86f6-669054fcca64.RDS --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m2itf4jl exposures/sigset3/3d15f518-2a92-4a86-86f6-669054fcca64 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules rsvsim --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m2itf4jl/772.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.m2itf4jl/772.jobfailed; exit 1)

