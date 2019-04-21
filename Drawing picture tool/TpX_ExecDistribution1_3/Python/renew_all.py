import os
'Script for refreshing all drawings in a specified directory'

tpx_path = '.........\\TpX.exe'
pics_path = '.........\\'
os.chdir(pics_path)
files = os.listdir(pics_path)
for input_filename0 in files:
  if input_filename0.find('.TpX')<0: continue
  input_filename0 = '%s%s'%(pics_path,input_filename0)
  code = os.system('%s -f"%s" -o'%(tpx_path,input_filename0))
  print input_filename0, code
