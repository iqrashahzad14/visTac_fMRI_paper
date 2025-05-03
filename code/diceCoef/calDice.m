% load_nii(char(fullfile(maskDir,roiName1)));
name1 = 'crossMod-Ext.nii';
name2 = 'crossMod-ext-allClusterst.nii';
name3 = 'rrhMT_fwe0pt05_currentCluster.nii';
name4 = 'rrhMT_p0pt05_currentCluster.nii';
name5 = 'rsub-ALL_hemi-R_space-MNI_label-rhMT_radiusNb-8.nii';


% cluster1 = load_nii(name1);
% notZero=length(find(cluster1.img~=0))
% notOne=length(find(cluster1.img~=1))
% notZero+notOne

%searchlight result of crossmodal decoding
cluster1 = load_nii(name1);notZeroOne1 = length(find(cluster1.img~=0 & cluster1.img~=1 ))
% cluster from vml at fwe corr
cluster3 = load_nii(name3);notZeroOne3 = length(find(cluster3.img~=0 & cluster3.img~=1 ))
%cluster from vml at p = o.o1 uncor
cluster4 = load_nii(name4);notZeroOne4 = length(find(cluster4.img~=0 & cluster4.img~=1 ))
% group level spherical roi of radus 8mm
cluster5 = load_nii(name5);notZeroOne5 = length(find(cluster5.img~=0 & cluster5.img~=1 ))


overlapMask = cluster1.img+cluster3.img;
voxOverlap =length(find(overlapMask == 2))
vA = length(find(cluster1.img == 1))
vB = length(find(cluster3.img == 1))
diceCoef = (2*voxOverlap)/(vA+vB)

overlapMask = cluster1.img+cluster4.img;
voxOverlap =length(find(overlapMask == 2))
vA = length(find(cluster1.img == 1))
vB = length(find(cluster3.img == 1))
diceCoef = (2*voxOverlap)/(vA+vB) % result is 0.9091

overlapMask = cluster1.img+cluster5.img;
voxOverlap =length(find(overlapMask == 2))
vA = length(find(cluster1.img == 1))
vB = length(find(cluster5.img == 1))
diceCoef = (2*voxOverlap)/(vA+vB)

