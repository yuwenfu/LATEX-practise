# Sample Python program using TpXpy
import TpXpy
import math
import os
from TpXpy import TpXpic,HTML_color

pic = TpXpic()
pic.addPolyline(((10,0), (30,-20), (15,-30)))
pic.fill('mintcream')
pic.lw(1.5)
pic.addPolygon(((0,-20), (10,0), (15,-30)))
pic.fill('floralwhite')
pic.lw(1.5)
pic.addLine(0,-20,30,-20)
pic.li('dash')
pic.addCurve(((0,-10), (5,-15), (25,-10), (15,-5), (10,-5)))
pic.closed()
pic.lw(0.5)
pic.ha(4)
pic.hc('silver')
pic.addPolygon(((5.56,-8.9),(12.45,-14.7),(18.3,-8.3)))
pic.li('dot')
pic.addLine(5.56,-8.9,10,0)
pic.lw(1.5)
pic.addLine(12.45,-14.7,10,0)
pic.lw(1.5)
pic.addLine(18.3,-8.3,10,0)
pic.lw(1.5)
pic.addSector(15, -30, 5.5, 0.6, 1.75)
pic.lw(0.5)
pic.addSector(15, -30, 6.5, 0.6, 1.75)
pic.lw(0.5)
pic.addSector(15, -30, 6, 1.75, 2.55)
pic.lw(0.5)
pic.addCircle(0,-20,0.4)
pic.li('none')
pic.fill('navy')
pic.addCircle(10,0,0.4)
pic.li('none')
pic.fill('navy')
pic.addCircle(15,-30,0.4)
pic.li('none')
pic.fill('navy')
pic.addCircle(30,-20,0.4)
pic.li('none')
pic.fill('navy')
pic.addLine(47,0,100,0)
for i in range(5):
  pic.addLine(i*10 + 50,-0.7,i*10 + 50,0.7)
  pic.addText(i*10 + 50, -1, 3, '%g'%(i*10), '\\texttt{%g}'%(i*10))
  pic.jh('r')
  pic.jv('t')
  pic.rotdeg(45)
pic.addLine(100,33,100,-33)
for i in range(7):
  pic.addLine(100-0.7,i*10-30,100+0.7,i*10-30)
  pic.addText(100+6,i*10-30-0.5, 3, '%g'%(i*10-30), '\\texttt{%g}'%(i*10-30))
  pic.jh('r')
  pic.jv('c')
pp = ()
for i in range(50):
  x = i + 50
  y = 30 * math.sin(x/5.0)
  p = (x, y),
  pp = pp + p
pic.addCurve(pp)
pic.li('dot')
pic.lw(2)
for i in range(50):
  x = i + 50
  y = 30 * math.sin(x/5.0)
  pic.addStar(x, y + math.sin(i**2*4)*5)
  pic.starShape('penta')
  pic.starD(0.8)
  pic.fill('lightgrey')
  pic.lw(0.4)
d = [0]
for ll in range(8):
  n = len(d)
  for i in range(n):
    d.append((d[n-i-1]+1)%4)
dd0 = [(1,0),(0,1),(-1,0),(0,-1)]
cc = ['blue','goldenrod','green','red']
step = 2.5
def PP(p):
  x = p[0][0]+5
  y = p[0][1]+15
  r = math.sqrt(x**2+y**2)
  c = 1 - math.cos(r/5)*0.05
  x = x*c
  y = y*c
  x,y = x+0.2*y,y-0.2*x
  return (x/1.5+23, y/1.5+25),
for j in range(4):
  pp = ()
  x,y = 0,0
  ddpre = [0, 0]
  p = (0, 0),
  pp = pp + PP(p)
  for i in range(len(d)):
    dd = dd0[(d[i]+j)%4]
    p = (x-ddpre[0]*step*0.1, y-ddpre[1]*step*0.1),
    pp = pp + PP(p)
    p = (x+dd[0]*step*0.1, y+dd[1]*step*0.1),
    pp = pp + PP(p)
    p = (x+dd[0]*step*0.5, y+dd[1]*step*0.5),  
    pp = pp + PP(p)
    x = x+dd[0]*step  
    y = y+dd[1]*step  
    ddpre = dd  
  p = (x, y),  
  pp = pp + PP(p) + PP(p) + PP(p)
  pic.addBezier(pp)
  pic.lc(cc[j])
pic.addRect(28, -6, 57, 57)
pic.rotdeg(45)
d=2.8
for i in range(12):
  for j in range(12):
    pic.addEllipse(i*d+70,j*d+43,d*0.7,d*0.9)
    pic.rotdeg(-45)
    pic.fill(HTML_color(255*(0.5+0.5*math.sin(i/3.+math.sin(j/3.)*2)),\
     255*(0.5+0.5*math.cos(j/3.-i**2/30.)),0))
    pic.li('none')
pic.addCurve(((25,75), (0,65), (-13,38)))
pic.arr('oc','h43',0.8)
pic.lw(0.5)
pic.addSymbol(52,70,25,'cloud1')
pic.lw(0.5)
pic.fill('whitesmoke')
pic.rotdeg(188)
pic.addText(52,70,5,'Fig 1')
pic.jh('c')
pic.jv('c')
pic.setCaption('A sample TpXpy picture', 'fig:TpXpy')
pic.setComment('Comment')
pic.setRootAttribute('PicUnitLength', 0.1)
pic.setRootAttribute('LineWidth', 0.25)
pic.setRootAttribute('MiterLimit', 1)
pic.setRootAttribute('HatchingStep', 1)
fname = 'sample_TpXpy.TpX'
pic.SaveToFile(fname)
os.startfile(fname)
