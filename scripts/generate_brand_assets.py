#!/usr/bin/env python3
"""Render vendored CC0 Soviet symbols and CC BY-SA 4.0 portraits.
See docs/brand/source/LICENSE-*.txt. Requires requirements-artwork.txt.
"""
from pathlib import Path
import io,json
import cairosvg
from PIL import Image
ROOT=Path(__file__).resolve().parents[1]
BRAND=ROOT/'apple/HakoClient/Resources/Branding'

import xml.etree.ElementTree as ET
from svgpathtools import parse_path, Line, CubicBezier
ns = '{http://www.w3.org/2000/svg}'
source = ET.parse(ROOT/'docs/brand/source/soviet-hammer-and-sickle.svg').getroot()
paths = [p.attrib['d'] for p in source.iter(ns+'path')]
def mark(color='#F7F4EE'):
    content = ''.join(f'<path fill="{color}" d="{d}"/>' for d in paths)
    return f'<g transform="translate(164 164) scale(4.64) translate(-165 -105)">{content}</g>'

# Compile the exact source geometry into a native SwiftUI Shape; no runtime parser.
lines = ['// Generated from the CC0 Soviet construction-sheet symbol. Do not edit.',
         '// Source and license: docs/brand/source/LICENSE-hammer-and-sickle.txt',
         'import SwiftUI', 'public struct SovietEmblem: Shape {',
         '    public init() {}', '    public func path(in rect: CGRect) -> Path {',
         '        var path = Path()']
def point(z): return f'CGPoint(x: {z.real-165:.8f}, y: {z.imag-105:.8f})'
for d in paths:
    segments=parse_path(d)
    lines.append('        path.move(to: '+point(segments[0].start)+')')
    for segment in segments:
        if isinstance(segment, Line): lines.append('        path.addLine(to: '+point(segment.end)+')')
        elif isinstance(segment, CubicBezier):
            lines.append('        path.addCurve(to: '+point(segment.end)+', control1: '+point(segment.control1)+', control2: '+point(segment.control2)+')')
        else: raise ValueError('Unexpected SVG segment; do not approximate the historical mark')
    lines.append('        path.closeSubpath()')
lines+=['        return path.applying(CGAffineTransform(scaleX: rect.width / 150, y: rect.height / 150))',
        '            .applying(CGAffineTransform(translationX: rect.minX, y: rect.minY))', '    }', '}']
(ROOT/'apple/HakoClientUI/Sources/HakoClientUI/Design/SovietEmblem.swift').write_text('\n'.join(lines)+'\n')

def svg(content):return f'<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="1024" viewBox="0 0 1024 1024">{content}</svg>\n'
def portrait_mark(color='#F7F4EE'):
    portrait=ET.parse(ROOT/'docs/brand/source/marx-engels-lenin.svg').getroot()
    portrait.set('width','820'); portrait.set('height','634')
    portrait.set('x','102'); portrait.set('y','195')
    for element in portrait.iter():
        if element.get('fill') == '#000000': element.set('fill',color)
    return ET.tostring(portrait,encoding='unicode')
portraits=svg(portrait_mark())
icon=svg('<rect width="1024" height="1024" fill="#8B1018"/>'+portrait_mark())
out=ROOT/'docs/brand';out.mkdir(parents=True,exist_ok=True)
(out/'marxism-mark.svg').write_text(svg(mark('#C8102E')))
(out/'marxism-icon.svg').write_text(icon)

def raster(source,w,h):
    return Image.open(io.BytesIO(cairosvg.svg2png(bytestring=source.encode(),output_width=w,output_height=h))).convert('RGBA')

def render_canvas(path,w,h,background,ratio=.80):
    image=Image.new('RGBA',(w,h),background)
    size=round(min(w,h)*ratio)
    logo=raster(portraits,size,size)
    image.alpha_composite(logo,((w-size)//2,(h-size)//2))
    image.save(path)

raster(icon,1024,1024).convert('RGB').save(ROOT/'apple/HakoClient/Assets.xcassets/AppIcon.appiconset/AppIcon1024.png')
raster(icon,1024,1024).save(BRAND/'AppIcon/macOS/HakoAppIcon.icns')
# Icon Composer keeps native platform masking and tinted variants.
composer=BRAND/'AppIcon/AppIcon.icon'
for old in (composer/'Assets').glob('*.svg'):old.unlink()
(composer/'Assets/portraits.svg').write_text(portraits)
d=json.loads((composer/'icon.json').read_text())
d['fill']={'solid':'extended-srgb:0.54510,0.06275,0.09412,1.00000'}
d['groups'][0]['layers']=[{'image-name':'portraits.svg','name':'Marx Engels Lenin — CC BY-SA 4.0','glass':False,'fill-specializations':[{'value':{'solid':'extended-srgb:0.96863,0.95686,0.93333,1.00000'}},{'appearance':'tinted','value':{'solid':'extended-srgb:1.00000,1.00000,1.00000,1.00000'}}]}]
(composer/'icon.json').write_text(json.dumps(d,indent=2)+'\n')
shared=BRAND/'SharedSymbols.xcassets'
(shared/'HakoBrandMark.imageset/HakoBrandMark.svg').write_text(svg(portrait_mark('#C8102E')))
template=svg(mark('#000000'))
(shared/'HakoMenuBarTemplate.imageset/HakoMenuBarTemplate.svg').write_text(template)
for suffix,size in [('',22),('@2x',44)]:raster(template,size,size).save(shared/f'HakoMenuBarTemplate.imageset/HakoMenuBarTemplate{suffix}.png')
# Preserve SF Symbols registration metadata; replace every silhouette with
# the CC0 filled paths (SF Symbols requires outlines rather than strokes).
import xml.etree.ElementTree as ET
ns = '{http://www.w3.org/2000/svg}'
ET.register_namespace('', ns[1:-1])
for name in ['hako.cat.fill','hako.cat.circle.fill']:
    tree=ET.fromstring((out/'symbol-template.svg').read_text())
    for group in tree.find(ns+'g[@id="Symbols"]'):
        for d in paths:
            ET.SubElement(group,ns+'path',{'d':d,'fill':'black','transform':'translate(-35 -70) scale(0.46666667) translate(-165 -105)'})
    target=shared/f'{name}.symbolset/{name}.svg'
    target.write_text('\n'.join(line.rstrip() for line in ET.tostring(tree,encoding='unicode').splitlines())+'\n')
    if name=='hako.cat.circle.fill':
        dest=ROOT/'apple/HakoMacClient/Sources/HakoMacClient/Resources/HakoSymbols.xcassets'/f'{name}.symbolset/{name}.svg'
        dest.write_text(target.read_text())
# TV layered artwork: preserve dimensions and foreground transparency.
for p in (BRAND/'AppIcon/tvOS').rglob('*.png'):
    with Image.open(p) as old:w,h=old.size
    if 'Background' in p.name:
        Image.new('RGB',(w,h),'#8B1018').save(p)
    elif 'Foreground' in p.name:render_canvas(p,w,h,(0,0,0,0),.78)
    else:render_canvas(p,w,h,'#8B1018',.72)
print('Rendered app icon, Icon Composer, menu bar and tvOS artwork.')
if __name__=='__main__':pass
