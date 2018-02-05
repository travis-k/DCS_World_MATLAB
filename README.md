# MATLAB - DCS World Interface

##### Tested on Windows 10, DCS World 2.5.0.12818, MATLAB 2017b.

Currently, a simple interface to communicate between DCS World and MATLAB. This method outputs data from DCS World via Export.lua, and catches it in MATLAB over TCP. 

  1. Copy Export.lua to C:\Users\\[USER]\Saved Games\DCS.openbeta\Scripts
  2. Run STREAM.m in MATLAB and wait for "Waiting for DCS client connection."
  3. 
  4. 

Notes:
- DCS World will begin running Export.lua only when the flight begins. Changes can be made to Export.lua between flights.
- After the connection between DCS and MATLAB is established, DCS must begin streaming data within 15 seconds or the connection will be closed.