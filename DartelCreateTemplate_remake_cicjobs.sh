#!/bin/sh
# ./DartelCreateTemplate_remake_cicjobs.sh

# analysis directory
AnalysisDir=/data/scratch/zakell/vbm #<- make sure this is correct
JobName="DartelCreateTemplate"

JobDir=$AnalysisDir/cicjobs/$JobName # cic job .m files kept here

# (re)make Job directory
test -d $JobDir && rm -r $JobDir
mkdir $JobDir
 # get template
TemplateFile=$AnalysisDir/Scripts/DartelCreateTemplate_job_template.m
if [ ! -f $TemplateFile ]; then
  printf "error: could not find TemplateFile at %s\n" $TemplateFile
  exit 1
fi

cicjoblistFile=$JobDir/cicjoblist
touch $cicjoblistFile

## make each jobs
JobFile=$JobDir/DartelCreateTemplate_rc1.m
touch $JobFile
echo "channel_prefixes = 'rc1';" > $JobFile
cat $TemplateFile >> $JobFile
echo "matlab -nodisplay -nodesktop -nosplash -r \"run('"$JobFile"')\"" >> $cicjoblistFile
printf "done making %s\n" $JobFile
unset JobFile

JobFile=$JobDir/DartelCreateTemplate_rc2.m
touch $JobFile
echo "channel_prefixes = 'rc2';" > $JobFile
cat $TemplateFile >> $JobFile
echo "matlab -nodisplay -nodesktop -nosplash -r \"run('"$JobFile"')\"" >> $cicjoblistFile
printf "done making %s\n" $JobFile
unset JobFile

JobFile=$JobDir/DartelCreateTemplate_rc1_rc2.m
touch $JobFile
echo "channel_prefixes = {'rc1', 'rc2'};" > $JobFile
echo "matlab -nodisplay -nodesktop -nosplash -r \"run('"$JobFile"')\"" >> $cicjoblistFile
cat $TemplateFile >> $JobFile
printf "done making %s\n" $JobFile

echo "Done making jobs. see "$JobDir
exit 0
