# HRTracker-flutter
This is a web dashboard to display your HRT progress. Fully Dockerized too, because why not?

`docker run -d -p 80:80 --name hrtracker -e STARTMS= -e HRTUSER= -e DOSEMG= -e DOSEINT= -e HRTFORM= -e HRTUNITS= 9021007/hrtracker`

| Environment Variable         | Use     |
|--------------|-----------|
| STARTMS | Epoch time (ms) of your first HRT dose      |
| HRTUSER      | Your name :)  |
| DOSEMG | mg per total dose, not per pill/shot/patch/etc      |
| DOSEINT      | Day interval of doses. E.g. once per week is 7  |
| HRTFORM | name of HRT delivery method, think "injections/patches/pills/gels/sprays/pellets" |
| HRTUNITS      | How many pills/shots/patches you use per dose  |

## Screenshot

![image](https://github.com/9021007/HRTracker/assets/24487638/0ec45ace-ebfd-432c-a68e-3e5ceb904e9e)
