from jinja2 import Template


def readLinks():
    links = []
    with open('links.txt', 'r') as linksFile:
        for link in linksFile.read().splitlines():
            if not '*' in link:
                continue
            link = link.replace(' ', '').replace('*', '')

            fields = {'name' : '', 'url' : '', 'logo' : ''}

            if "->" in link:
                link = link.split('->')
                fields['name'] = link[0]
                link = link[1]
            if "<-" in link:
                link = link.split('<-')
                fields['logo'] = link[1]
                link = link[0]

            for field in fields:
                fields[field] = link if fields[field] == '' else fields[field]

            links.append(fields)
    return links


html = open('template.html', 'r').read()
template = Template(html)
with open('index.html', 'w') as out:
    out.write(template.render({'links' : readLinks()}))
