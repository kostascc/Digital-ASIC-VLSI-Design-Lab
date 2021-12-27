# Digital-ASIC-VLSI-Design-Lab

This is part of the *Digital Large-Scale VLSI-ASIC ICs* lab of 2021-2022.

## Run
The script `run.sh` initializes a ***Gennus*** environment, imports the design, checks the constraints at `./sdc/` and synthesizes the design.
***Innovus*** is also automatically initialized after a successfull synthesis, for ***Placing, Routing*** and ***DRC*** checks.
```
chmod +x ./run.sh && ./run.sh
```

Several detailed reports of all the above-mentioned steps will be created in the directory `./reports/`.

