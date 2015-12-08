#!/bin/bash

maskdir=${1}
subject=${2}

ProjectDIR=/project_space/SHSS

export ANTSPATH=/usr/local/ANTs-2.1.0-rc3/bin/
mkdir -p ${ProjectDIR}/subjects/${subject}/rest/seedmasks/

for mask in `ls $maskdir/*Sphere*.nii.gz`; do
	echo Working on $mask

	${ANTSPATH}/WarpImageMultiTransform 3 ${mask} ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_in_custom.nii.gz -R ${ProjectDIR}/standard/custom_template.nii.gz -i ${ProjectDIR}/standard/custom_to_mni_Affine.txt ${ProjectDIR}/standard/custom_to_mni_InverseWarp.nii.gz
	${ANTSPATH}/WarpImageMultiTransform 3 ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_in_custom.nii.gz ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_in_T1.nii.gz -R ${ProjectDIR}/subjects/${subject}/memprage/T1_brain.nii.gz -i ${ProjectDIR}/subjects/${subject}/xfm_dir/T1_to_custom_Affine.txt ${ProjectDIR}/subjects/${subject}/xfm_dir/T1_to_custom_InverseWarp.nii.gz
	${ANTSPATH}/WarpImageMultiTransform 3 ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_in_T1.nii.gz ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_in_rest.nii.gz -R ${ProjectDIR}/subjects/${subject}/rest/rest_e00213_tsoc_reoriented_vol0.nii.gz -i ${ProjectDIR}/subjects/${subject}/xfm_dir/rest_e00213_tsoc_reoriented_to_T1_ras.txt
	
	fslmaths ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_in_rest.nii.gz -thr 0.5 -bin ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_in_rest.nii.gz

	fslmeants -i ${ProjectDIR}/subjects/${subject}/rest/rest_e00213_medn_reoriented.nii.gz -m ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_in_rest.nii.gz | head -n -1 > ${ProjectDIR}/subjects/${subject}/rest/seedmasks/`basename ${mask} .nii.gz`_ts.txt

done

