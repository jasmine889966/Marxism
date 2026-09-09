#!/usr/bin/env python3
"""Check the derivative's compatibility boundaries, localized copy and artwork provenance."""
from pathlib import Path
import json,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
BASE='b05832246fcac69d13ff16df871a8d53fd394c10'
errors=[]
protected=['Dependencies.lock.json','LICENSE','apple/HakoClient/Extension',
 'apple/HakoClient/Sources/ConfigStore','apple/HakoClient/Sources/NodesModel.swift',
 'apple/HakoClient/Sources/ClashCommandClient.swift',
 'apple/HakoClientUI/Sources/HakoClientUI/Model',
 'apple/HakoClientUI/Sources/HakoClientUI/Features/Home/HakoHomeSnapshot.swift',
 'apple/HakoClientUI/Sources/HakoClientUI/Navigation/AppleClientNavigation.swift',
 'apple/HakoClientUI/Sources/HakoClientUI/Design/HakoRegionalFlag.swift']
changed=subprocess.check_output(['git','diff',BASE,'--name-only','--',*protected],cwd=ROOT,text=True)
if changed.strip():errors.append('Protected network/model/license files changed: '+changed)
keys=['Workers of all countries, unite!',
 'Communism is Soviet power plus the electrification of the whole country.',
 'Lenin, 1920','Karl Marx, Friedrich Engels and Vladimir Lenin',
 'Connect to communism','Disconnect the link','Cancel the link','Rebuild the link',
 'Configure the link','International Links','Line Construction',
 'Proxy Stations','Routing Principles','Link Activity','Configuration Archives',
 'Engineering Tools','More Settings']
catalogs=list((ROOT/'apple/HakoClient').rglob('Localizable.strings'))
for p in catalogs:
 if '.build' in p.parts:continue
 text=p.read_text()
 for key in keys:
  if len(re.findall(r'^"'+re.escape(key)+r'"\s*=',text,re.M))!=1:
   errors.append(f'Missing/duplicate localized key {key}: {p.relative_to(ROOT)}')
for p in (ROOT/'apple').rglob('Contents.json'):
 if '.build' in p.parts:continue
 try:json.loads(p.read_text())
 except ValueError:errors.append('Invalid asset catalog: '+str(p))
for name in ['LICENSE-hammer-and-sickle.txt','LICENSE-portraits.txt']:
 if not (ROOT/'docs/brand/source'/name).is_file():errors.append('Missing artwork notice: '+name)
for name in ['SovietColors','SovietTypography','SovietSpacing','SovietRadius','SovietShadow','SovietIconography']:
 if 'enum '+name not in (ROOT/'apple/HakoClientUI/Sources/HakoClientUI/Design/SovietTheme.swift').read_text():errors.append('Missing token family: '+name)
if errors:
 print('\n'.join(errors));sys.exit(1)
print(f'PASS: protected source/lock/license boundaries; {len(catalogs)} localization catalogs; artwork notices; theme token families.')
