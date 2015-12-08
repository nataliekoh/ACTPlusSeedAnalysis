#! /bin/bash

echo subject,run,L_Angular_Gyrus_to_L_Lateral_Temporal,L_Angular_Gyrus_to_R_Angular_Gyrus,L_Angular_Gyrus_to_R_Lateral_Temporal,L_Lateral_Temporal_to_R_Lateral_Temporal,Medial_Prefrontal_Cortex_to_L_Angular_Gyrus,Medial_Prefrontal_Cortex_to_L_Lateral_Temporal,Medial_Prefrontal_Cortex_to_R_Angular_Gyrus,Medial_Prefrontal_Cortex_to_R_Lateral_Temporal,Posterior_Cingulate_to_L_Angular_Gyrus,Posterior_Cingulate_to_L_Lateral_Temporal,Posterior_Cingulate_to_Medial_Prefrontal_Cortex,Posterior_Cingulate_to_R_Angular_Gyrus,Posterior_Cingulate_to_R_Lateral_Temporal,R_Angular_Gyrus_to_L_Lateral_Temporal,R_Angular_Gyrus_to_R_Lateral_Temporal > /project_space/SHSS/DMNCorrelations.csv

cd /project_space/SHSS/subjects/

for subject in `ls -d SHSS_??`; do	
	cd ${subject}
	echo ${subject}	
	for run in rest; do
		allcors=`cat ${run}/seedmasks/corr_LAG_to_Llattemp`
		for corr in corr_LAG_to_RAG corr_LAG_to_Rlattemp corr_Llattemp_to_Rlattemp corr_mPFC_to_LAG corr_mPFC_to_Llattemp corr_mPFC_to_RAG corr_mPFC_to_Rlattemp corr_PCC_to_LAG corr_PCC_to_Llattemp corr_PCC_to_mPFC corr_PCC_to_RAG corr_PCC_to_Rlattemp corr_RAG_to_Llattemp corr_RAG_to_Rlattemp; do
		corrval=`cat ${run}/seedmasks/${corr}`
		allcors=`echo $allcors,$corrval`
	done
	echo ${subject},${run},${allcors} >> /project_space/SHSS/DMNCorrelations.csv
	done
	cd  /project_space/SHSS/subjects/	
done
