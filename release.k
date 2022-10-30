unfix				MV1
unfix				MV2
unfix				ROLL
group 				ROLLER1 delete
group 				ROLLER2 delete
group 				ROLLERS delete
delete_atoms 		group NiAtoms${rollp} compress yes

change_box 			all boundary p p p

# Output Data

shell				cd roll${rollp}.out
shell 				cd datafiles${rollp}

thermo_style		custom step 
dump 				1 all cfg/mpiio 1 Final${rollp}_*.cfg mass type xs ys zs id c_PEa c_atomST[1] c_atomST[2] c_atomST[3]
dump_modify 		1 element Fe Cu Ni
run					0
undump				1
	
write_data 			FeCu${rollp}.dat																	  								

shell 				cd ..
shell 				cd ..