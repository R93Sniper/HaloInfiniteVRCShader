# Halo Infinite Unity Shader
An open source unity shader designed to emulate the look of Halo Infinite's shader system

This was designed for use in VRChat, but may be used in other non-profit applications in Unity

No files in any part of this repository contains or will be allowed to contain copyrighted work that does not belong to the owners of the submission

All versions of this shader, it's derivatives, and similar shaders that use this shader for information, must be open source and available to all free of charge

[If You Are Looking For The Download Link, Click Here, And Download The 'Source Code (.zip)'](https://github.com/R93Sniper/HaloInfiniteVRCShader/releases/latest)

----------------------------------------------------------------------------------------------

Original Shader made in Unreal Engine 4 by R93 Sniper

Unity Amplify Shader port by PointDevice

This shader exclusively belongs to R93 Sniper and PointDevice

----------------------------------------------------------------------------------------------

THIS MAY NOT BE USED FOR COMMERCIAL PURPOSES





Installation Instructions
----------------------------------------------------------------------------------------------
1. Download the Shader (as of writing, it is only the armor and visor shader)
2. Download the MaterialFunction
3. Place both in the same folder of your unity project

You should now have the shaders listed as options under 'Halo Infinite' section in the shader list


Usage Instructions
----------------------------------------------------------------------------------------------
- All Textures must be marked with sRGB off
- Zone 6 is always considered to be the grunge map
- If your item only has 1 CC map, put it in the CC2 slot

Change Log
----------------------------------------------------------------------------------------------
v0.4 - Bumpy Roads Ahead(This only applies to the advanced version of the shader, and introduces the visor shader)
	
	-Added system for using the scratch and grunge maps to add normal effect, this is done after the adjustments to the maps so some control is had with the contrast
	
	-changed how the zone for emissives are selected to allow for more compatability
	
	-Added option for CC2B to mixed additively or replacing color, this is for compatability with darker colors and with master chief
	
	-NEW visor shader to work with gradient maps from the game files, there is still some known issues with this, but is good enough to be put on here 
		
		=uses the same textures as the helmet, but with added detail normal and texture for gradient maps
		
		=works with the coloring of the gradient maps with the 3 color sub zones, and scratches(has some issues currently)
		
		=THIS IS ONLY FOR USE WITH THE GAME FILE GRADIENT MAPS, IF YOU DO NOT HAVE THESE, OR WANT TO USE OTHER TEXTURES, USE THE STANDARD OR ADVANCED ARMOR SHADERS INSTEAD

v0.35 - Yin and Yang - first major release 

	-renamed to standard 
	
	-some variables renamed to be more clear to the end user 
	
	-some internal variable names changed to line up with their equivalents in standard for vrchat fallbacks
	
	- added advanced version which presents more features for fine tuning such as:
	
		= per zone metallic and roughness
		
		= takes into account the dust layer 
		
		= changes to how emissives are handeled internally 

v0.2 - some changes to how the metallic value is used, and blending of the detail tileables

v0.1 initial release, no notes 
