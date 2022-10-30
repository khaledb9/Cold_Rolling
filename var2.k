# Store lengths

variable 		tmp 	equal 	"lx"		
variable		LX 		equal 	401.075028584497		
variable 		tmp 	equal 	"ly"
variable		LY 		equal 	250.671892865316	
variable 		tmp 	equal 	"lz"
variable 		LZ		equal 	200.537514292249	

# Rollers Parameters

variable		RR		equal	90.0			# Roller Radius	(half of sample heigh to reduce angle of contact)	
variable		RL		equal	${LY}			# Roller Length

# New box dimensions

variable 		tmp 	equal 	"xlo"	
variable		L0x 	equal 	-0.537514292251814										        						# Init  x coord 
variable 		tmp 	equal 	"ylo"	                            		        				
variable		L0y 	equal 	-0.335946432658403										        						# Init  y coord 
variable 		tmp 	equal 	"zlo"	                            		        				
variable		L0z 	equal 	"v_tmp - 2.0 - (v_RR*2)"					        						# Init  z coord 
variable		L0Z 	equal 	-182.268757146126										        							# Store it 
variable		Lfx		equal 	"v_LX + 16.0 + (v_RR*8) + v_Lf2 + v_Lf + 16.0 + v_Lf3 + v_Lf4+(v_RR*2.5)"				# Final x coord
variable		Lfy		equal	${LY}										        						# Final y coord
variable		Lfz		equal	"v_LZ + 2.0 + (v_RR*2)"						        						# Final z coord
variable 		X1 		equal 	"xhi - 5"
variable 		X2 		equal 	"xhi" 

# Group to calculate velocity for

region      	front 	block ${X1} ${X2} INF INF INF INF units box
group    		FS 		region front

# Rollers Positions

variable		Rx		equal "abs(v_LX) + v_RR "							# Rollers position in x for pass:1
variable        rp		equal 0.15											# Single pass = 10% roll
variable		Lf		equal "(v_LX*v_LY*v_LZ)/(v_LY*v_LZ*(1-v_rp))"		# Final length due rolling for pass:1	
variable 		Rd		equal "v_LZ - (v_LZ*v_rp)"							# Distance between rollers for pass:1
variable 		ofs		equal "(-v_Rd+v_LZ)*0.5"							# Offset for pass:1
variable		R1z		equal "(v_Lfz-v_RR)-v_ofs  "						# Upper roller position in z for pass:1
variable		R2z		equal "((v_RR)+v_L0Z)+v_ofs"						# Lower roller position in z for pass:1

variable		Rx2		equal "v_Rx + v_Lf + (v_RR*2) + 30.0"				# Rollers2 position in x for pass:2
variable		Lf2		equal "(v_LX*v_LY*v_LZ)/(v_LY*v_LZ*(1-(v_rp*2)))"	# Final length due rolling for pass:2
variable		Rx3		equal "v_Rx2 + v_Lf2 + (v_RR*2) + 30.0"				# Rollers3 position in x for pass:3
variable		Lf3		equal "(v_LX*v_LY*v_LZ)/(v_LY*v_LZ*(1-(v_rp*3)))"	# Final length due rolling	 for pass:3
variable		Rx4		equal "v_Rx3 + v_Lf3 + (v_RR*2) + 80.0"				# Rollers4 position in x for pass:4
variable		Lf4		equal "(v_LX*v_LY*v_LZ)/(v_LY*v_LZ*(1-(v_rp*4)))"	# Final length due rolling for pass:4
variable		Rposx	index ${Rx} ${Rx2} ${Rx3} ${Rx4}

variable		Rd2		equal "v_LZ - (v_LZ*v_rp*2) "						# Distance between rollers for pass:2
variable 		ofs2	equal "(-v_Rd2+v_LZ)*0.5"							# Offset for pass:2
variable		R1z2	equal "(v_Lfz-v_RR)-v_ofs2 "						# Upper roller position in z for pass:2
variable		R2z2	equal "((v_RR)+v_L0Z)+v_ofs2"						# Lower roller position in z for pass:2

variable		Rd3		equal "v_LZ - (v_LZ*v_rp*3)"						# Distance between rollers for pass:3
variable 		ofs3	equal "(-v_Rd3+v_LZ)*0.5"							# Offset for pass:3
variable		R1z3	equal "(v_Lfz-v_RR)-v_ofs3 "						# Upper roller position in z for pass:3
variable		R2z3	equal "((v_RR)+v_L0Z)+v_ofs3"						# Lower roller position in z for pass:3

variable		Rd4		equal "v_LZ - (v_LZ*v_rp*4)"						# Distance between rollers for pass:4
variable 		ofs4	equal "(-v_Rd4+v_LZ)*0.5"							# Offset for pass:4
variable		R1z4	equal "(v_Lfz-v_RR)-v_ofs4 "						# Upper roller position in z for pass:4
variable		R2z4	equal "((v_RR)+v_L0Z)+v_ofs4"						# Lower roller position in z for pass:4

variable		Rposz1	index ${R1z} ${R1z2} ${R1z3} ${R1z4}
variable		Rposz2	index ${R2z} ${R2z2} ${R2z3} ${R2z4}