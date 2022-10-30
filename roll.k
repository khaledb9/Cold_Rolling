# Roll 

shell			mkdir roll${rollp}.out
shell			cd    roll${rollp}.out
shell			mkdir datafiles${rollp}

# Compute thermo data for the sample

compute			Temp  Sample temp/partial 0 1 1
compute			PEa	  Sample pe/atom			
compute			PE 	  Sample reduce sum c_PEa
compute 		atomST all stress/atom NULL
fix_modify      NVT   temp Temp

group			NiAtoms${rollp} type 3
comm_style  	tiled
balance 	 	1.0 rcb
fix				2 all balance 4000 1.0 rcb 

variable 		pos      equal "v_Rposx + v_RR + 10.0"
variable 		Criteria equal ${pos}

print 			"========================================================="
print 			"Rolling Started: ${rollp} ... Stop --> Dimx1 > Criteria"
print 			"========================================================="

# Move the sample with some force to overcome the repulsion

set 			group  Sample vx 2.0
fix 			ADF Sample addforce 0.004 0.0 0.0 every 10		# Add force to move the sample

# Output Some Data to monitor with tail 

variable 		stp equal "step"
variable 		prt equal "c_Temp"
fix 			PRINT all print 500 "${stp} ${prt} ${SPD} ${Dimx1} ${Criteria}" file ${rollp}.dat screen no

# Output Images 

dump 			1 all image 2000 Rolling_*.jpg  type type shiny 0.0 size 1920 1080 center s 1.25 0.65 0.65 box no 0.0 zoom 1.2 view 90 90 ssao yes 524247 0.2
dump_modify		1 acolor 1 red acolor 2 yellow acolor 3 darkgreen adiam 1 2.52 adiam 2 2.8 adiam 3 2.3 backcolor white

#Output Movie 

dump 			3 all movie 150 RollingMovie${rollp}.avi type type shiny 0.0 size 1920 1080 center s 1.25 0.65 0.65 box no 0.0 zoom 1.2 view 60 60 ssao yes 76373 0.2
dump_modify		3 acolor 1 red acolor 2 yellow acolor 3 darkgreen adiam 1 2.52 adiam 2 2.8 adiam 3 2.3 backcolor white bitrate 4000

thermo 			100
thermo_style	custom step c_Temp c_PE v_SPD v_Dimx1 v_Criteria
fix       		cent Sample recenter NULL INIT INIT units box
fix				1 Sample halt 1 v_Dimx1 > ${pos} error continue 
run 			8000000	upto
unfix 			1
unfix 			2
unfix 			ADF
undump			1
undump			3

shell			cd ..