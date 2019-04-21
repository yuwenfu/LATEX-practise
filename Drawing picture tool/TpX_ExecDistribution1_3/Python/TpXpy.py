import xml.dom.minidom
class TpXpic:
  "Python module to generate TpX drawings"
  def __init__(self):
    self.aXML = xml.dom.minidom.getDOMImplementation().createDocument(None, "TpX", None)
    self.XMLtop = self.aXML.documentElement
    self.XMLtop.setAttribute('v', '3')
  def __del__(self):
    self.aXML.unlink()
  def as_text(self):
    t = self.aXML.toprettyxml('  ', '\n')
    t = t.replace('<caption>\n    ','<caption>')
    t = t.replace('\n  </caption>','</caption>')
    t = t.replace('<comment>\n    ','<comment>')
    t = t.replace('\n  </comment>','</comment>')
    t = t.replace('">\n    ','">')
    t = t.replace('\n','\n%')
    j = t.find('\n')
    t = t[j+1:]
    j = t.rfind('\n')
    t = t[:j]
    return t
  def setRootAttribute(self, elID, s):
    self.XMLtop.setAttribute(elID, str(s))
  def setEl(self, elID):
    el = self.XMLtop.getElementsByTagName(elID)
    if len(el)>0:
      self.last = self.aXML.createElement(elID)
      self.XMLtop.removeChild(el[0]).unlink()
    else:
      self.last = self.aXML.createElement(elID)
    self.XMLtop.appendChild(self.last)
    return self.last
  def setCaption(self, s, label=None):
    self.setEl('caption').appendChild(self.aXML.createTextNode(s))
    if label!=None:
      self.a('label', label)
  def setComment(self, s):
    self.setEl('comment').appendChild(self.aXML.createTextNode(s))
  def addEl(self, elID):
    self.last = self.aXML.createElement(elID)
    self.XMLtop.appendChild(self.last)
    return self.last
  def a(self, elID, elValue, el=None):
    if el==None:
      self.last.setAttribute(elID, str(elValue))
    else:
      el.setAttribute(elID, str(elValue))
  def lc(self, cl, el=None):
    "set line color"
    self.a('lc', cl, el)
  def lw(self, w, el=None):
    "set line width"
    self.a('lw', w, el)
  def li(self, li, el=None):
    "set line style: none, dot, dash or solid (default)"
    self.a('li', li, el)
  def ha(self, ha, el=None):
    "set hatching: 1,...,6"
    self.a('ha', ha, el)      
  def hc(self, cl, el=None):
    "set hatching color"
    self.a('hc', cl, el)      
  def fill(self, cl, el=None):
    "set fill color"
    self.a('fill', cl, el)
  def addLine(self, x1, y1, x2, y2):
    "add line"
    self.last = self.addEl('line')
    self.a('x1', str(x1))
    self.a('y1', str(y1))
    self.a('x2', str(x2))
    self.a('y2', str(y2))
    return self.last
  def arr(self, arr1=None, arr2=None, arrs=None, el=None):
    "add arrow-heads; arr1,arr2: none, h40, h41, h42, h43, h44, h45, h46, h47, h48, t40, t43, t44, t45, h20, h21, h22, h23, h24, t20, t21, t22, t23, hr10, hr11, hr12, tr10, h10, h11, h12, h12c, t10, r0, r10, r11, r12, r20, r20c, r21, r33, ts10, ts11, ts12, hs10, hs12, ts20, ts21, ts23, hs20, hs23, o, oc, qq;"
    "arrs is arrow-head size factor"
    if arr1!=None:
      self.a('arr1', arr1, el)
    if arr2!=None:
      self.a('arr2', arr2, el)
    if arrs!=None:
      self.a('arrs', str(arrs), el)      
  def addRect(self, x, y, w, h):
    "add rectangle"
    self.last = self.addEl('rect')
    self.a('x', str(x))
    self.a('y', str(y))
    self.a('w', str(w))
    self.a('h', str(h))
    return self.last
  def rotdeg(self, rotdeg, el=None):
    self.a('rotdeg', rotdeg, el)
  def addCircle(self, x, y, d):
    "add circle"
    self.last = self.addEl('circle')
    self.a('x', str(x))
    self.a('y', str(y))
    self.a('d', str(d))
    return self.last
  def addEllipse(self, x, y, dx, dy):
    "add ellipse"
    self.last = self.addEl('ellipse')
    self.a('x', str(x))
    self.a('y', str(y))
    self.a('dx', str(dx))
    self.a('dy', str(dy))
    return self.last
  def points_str(self, pp):
    s = ''
    for i in range(len(pp)):
      s = s + str(pp[i][0]) + ',' + str(pp[i][1]) + ' '
    return s
  def addPolyline(self, pp):
    "add polyline"
    self.last = self.addEl('polyline')
    self.last.appendChild(self.aXML.createTextNode(self.points_str(pp)))
    return self.last
  def addPolygon(self, pp):
    "add polygon"
    self.last = self.addEl('polygon')
    self.last.appendChild(self.aXML.createTextNode(self.points_str(pp)))
    return self.last
  def addCircular(self, aID, x, y, d, a1, a2):
    "add circular primitive"
    self.last = self.addEl(aID)
    self.a('x', str(x))
    self.a('y', str(y))
    self.a('d', str(d))
    self.a('a1', str(a1))
    self.a('a2', str(a2))
    return self.last
  def addArc(self, x, y, d, a1, a2):
    "add arc"
    return self.addCircular('arc', x, y, d, a1, a2)
  def addSegment(self, x, y, d, a1, a2):
    "add segment"
    return self.addCircular('segment', x, y, d, a1, a2)
  def addSector(self, x, y, d, a1, a2):
    "add sector"
    return self.addCircular('sector', x, y, d, a1, a2)
  def addCurve(self, pp):
    "add curve"
    self.last = self.addEl('curve')
    self.last.appendChild(self.aXML.createTextNode(self.points_str(pp)))
    return self.last    
  def closed(self, el=None):
    "make a curve closed"  
    self.a('closed', 1, el)
  def addBezier(self, pp):
    "add Bezier path"
    self.last = self.addEl('bezier')
    self.last.appendChild(self.aXML.createTextNode(self.points_str(pp)))
    return self.last
  def addText(self, x, y, h, t, tex=None):
    "add text label"
    self.last = self.addEl('text')
    self.a('x', str(x))
    self.a('y', str(y))
    self.a('h', str(h))
    self.a('t', t)
    if tex!=None:
      self.a('tex', tex)
    return self.last
  def jh(self, j, el=None):
    "set text horizontal justification: l (left, default), c (center) or r (right)"
    self.a('jh', j, el)
  def jv(self, j, el=None):
    "set text vertical justification: 0 (baseline, default), b (bottom), c (center) or t (top)"
    self.a('jv', j, el)
  def addStar(self, x, y, s=None):
    "add star"
    self.last = self.addEl('star')
    self.a('x', str(x))
    self.a('y', str(y))
    if s!=None:
      self.a('s', s)
    return self.last
  def starShape(self, s, el=None):
    "set star shape: circle (default), square, diamond, triup, tridown, penta, star4, star5, star6, cross, dcross, flower5, flower4, star4arc, maltese"
    self.a('s', s, el)
  def starD(self, d, el=None):
    "set star size factor"
    self.a('d', str(d), el)
  def addSymbol(self, x, y, d, s=None):
    "add symbol"
    self.last = self.addEl('symbol')
    self.a('x', str(x))
    self.a('y', str(y))
    self.a('d', str(d))
    if s!=None:
      self.a('s', s)
    return self.last
  def symbShape(self, s, el=None):
    "set symbol shape: process, decision, input-output, preparation, punch-card, manual-op, keyboard, punch-tape, document, documents, display, terminal, keying, alt-process, online-storage, magnetic-drum, magnetic-tape, hoarrow1, hoarrow1v, hoarrow2, hoarrow3, hoarrow4, star5, diamond8, baloon1, baloon2, cloud1, splash1, snowflake1"
    self.a('s', s, el)
  def SaveToFile(self, FileName):
    f = file(FileName, 'w')
    f.write(self.as_text())
    f.close()

def HTML_color(r,g,b):
  "Make HTML color from RGB levels"
  r=round(r);g=round(g);b=round(b)
  if r<0:r=0
  if r>255:r=255
  if g<0:g=0
  if g>255:g=255
  if b<0:b=0
  if b>255:b=255
  return '#%02X%02X%02X'%(r,g,b)
  
