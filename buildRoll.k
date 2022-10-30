# Create Rollers Set
# Rolling direction --> x
# Transverse direction --> y
# Normal direction --> z


# Change box size to occupy rollers set 

change_box		all x final ${L0x} ${Lfx} y final ${L0y} ${Lfy} z final ${L0z} ${Lfz} units box

# Build the rollers 

lattice    	 	diamond 3.56
region			Roller1_${rollp} cylinder y ${Rposx} ${Rposz1} ${RR} ${L0y} ${Lfy} units box 
create_atoms	3 region Roller1_${rollp}

lattice    	 	diamond 3.56
region			Roller2_${rollp} cylinder y ${Rposx} ${Rposz2} ${RR} ${L0y} ${Lfy} units box 
create_atoms	3 region Roller2_${rollp}

# Group rollers

region			Rollers_${rollp} union 2 Roller1_${rollp} Roller2_${rollp} units box
group 			ROLLER1 region Roller1_${rollp}
group 			ROLLER2 region Roller2_${rollp}
group 			ROLLERS region Rollers_${rollp}

# Make rigid

fix				ROLL ROLLERS rigid group 2 ROLLER1 ROLLER2 force * off off off torque * off on off 

# Make boundary shrink and wrap to account for after-rolling expansion

change_box 		all boundary s p s

# Rollers Rotation
# The translational component of rotation must be faster than the sample velocity v=2pi*rev*r

fix 			MV1 ROLLER1 move rotate ${Rposx} ${L0y} ${Rposz1} 0 -1 0 30.0 units box 
fix 			MV2 ROLLER2 move rotate ${Rposx} ${L0y} ${Rposz2} 0  1 0 30.0 units box 
