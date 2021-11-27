# Halo Infinite Unity Shader
An open source unity shader designed to emulate the look of Halo Infinite's shader system

This was designed for use in VRChat, but may be used in other non-profit applications in Unity

No files in any part of this repository contains or will be allowed to contain copyrighted work that does not belong to the owners of the submission

All versions of this shader, it's derivatives, and similar shaders that use this shader for information, must be open source and available to all free of charge

----------------------------------------------------------------------------------------------

Original Shader made in Unreal Engine 4 by R93 Sniper

Unity Amplify Shader port by PointDevice

This shader exclusively belongs to R93 Sniper and PointDevice

----------------------------------------------------------------------------------------------

THIS MAY NOT BE USED FOR COMMERCIAL PURPOSES





Installation Instructions
----------------------------------------------------------------------------------------------
1. Download the Shader (as of writing, it is only the armor shader)
2. Download the MaterialFunction
3. Place both in the same folder of your unity project

You should now have the shader as an option under Halo Infinite / Armor Base


Usage Instructions
----------------------------------------------------------------------------------------------
- All Textures must be marked with sRGB off
- Zone 6 is always considered to be the grunge map
- If your item only has 1 CC map, put it in the CC2 slot

Change Log
----------------------------------------------------------------------------------------------

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
