# parse all .xml files recursively in a directory
# find all <uientry> tags and extract their properties

import os
import sys

from lxml import etree

title1_props = {}
title2_props = {}


def parse_props(xml_file):
    tree = etree.parse(xml_file)
    root = tree.getroot()
    for uientry in root.iter('uientry'):
        # uientry has <properties> tag
        properties = uientry.find('properties')
        if properties is not None:

            title1 = uientry[2].text
            title2 = uientry[4].text
            props = {}
            for prop in properties:
                # first child is the key, second child is the value
                key = prop[0].text
                value = prop[2].text
                print(f'{key}: {value}')
                props[key] = value

            if not props:
                continue

            if title1 not in title1_props:
                title1_props[title1] = []
            title1_props[title1].append(props)

            if title2 not in title2_props:
                title2_props[title2] = []
            title2_props[title2].append(props)

def parse_all_xml_files(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.xml'):
                try:
                    parse_props(os.path.join(root, file))
                except Exception as e:
                    print(f'Error parsing {file}: {e}')


if __name__ == '__main__':
    parse_all_xml_files(sys.argv[1])

    # dump all properties to json file
    import json

    with open('title1_props.json', 'w') as f:
        json.dump(title1_props, f, indent=4)

    with open('title2_props.json', 'w') as f:
        json.dump(title2_props, f, indent=4)
