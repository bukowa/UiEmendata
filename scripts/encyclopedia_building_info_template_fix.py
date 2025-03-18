import sys
from enum import Enum
from lxml import etree

SLIDER_UNITS_ID = '509453121'
SLIDER_DETAILS_ID = '509453120'


class Switches(Enum):
    """
    Enum that represents the switches for the encyclopedia.
    """
    NONE = 0
    OFF_SLIDER_UNITS = 1
    OFF_SLIDER_DETAILS = 2


def switch_slider(root: etree.Element, switches: set[Switches]) -> etree.Element:
    """
    Determines whether the slider should be switched off based on given switches.
    """

    def _delete_props():
        _p = uientry.find('properties')
        _p.set('count', '0')
        for _c in _p:
            _p.remove(_c)

    print('Switching off slider for units')
    for uientry in root.iter('uientry'):
        if uientry.find('u').text == SLIDER_UNITS_ID:
            value = "no" if Switches.OFF_SLIDER_UNITS in switches else "yes"
            uientry[24].tag = value
            if value == "no":
                _delete_props()
            print(f"Switched off slider for units: {value}")


    print('Checking off slider for details')
    for uientry in root.iter('uientry'):
        if uientry.find('u').text == SLIDER_DETAILS_ID:
            value = "no" if Switches.OFF_SLIDER_DETAILS in switches else "yes"
            uientry[24].tag = value
            if value == "no":
                _delete_props()
            print(f"Switched off slider for details: {value}")

    return root


def replace_self_closing_tags(xml_string):
    replacement_dict = {
        '<s/><!-- end of uientry 1? -->': '<s></s><!-- end of uientry 1? -->',
        '<s/><!-- end of uientry 2? -->': '<s></s><!-- end of uientry 2? -->',
        '<s/><!-- title2 -->': '<s></s><!-- title2 -->',
        '<unicode/><!-- tooltip text -->': '<unicode></unicode><!-- tooltip text -->',
        '<unicode/><!-- tooltip id -->': '<unicode></unicode><!-- tooltip id -->',
        '<s/><!-- path -->': '<s></s><!-- path -->',
        '<unicode/><!-- state text -->': '<unicode></unicode><!-- state text -->',
        '<unicode/><!-- tooltip -->': '<unicode></unicode><!-- tooltip -->',
        '<unicode/><!-- text label? -->': '<unicode></unicode><!-- text label? -->',
        '<unicode/><!-- localization id -->': '<unicode></unicode><!-- localization id -->',
        '<s/><!-- shader name -->': '<s></s><!-- shader name -->',
        '<no/>': '<no />',
        '<yes/>': '<yes />',
        '<s/>': '<s></s>',
        # Add more exact replacements as needed
    }

    # Iterate through the dictionary and replace exact matches
    for old_text, new_text in replacement_dict.items():
        xml_string = xml_string.replace(old_text, new_text)

    return xml_string


if __name__ == '__main__':
    _encyclopedia_file_path = 'src/ui/common ui/encyclopedia_building_info_template.xml'

    # Load XML
    with open(_encyclopedia_file_path, 'r') as file:
        _encyclopedia = etree.parse(file)

    # Parse command-line arguments into a set of switches
    _arg_switches = {Switches(int(arg)) for arg in sys.argv[1].split(',')} if len(sys.argv) > 1 else {Switches.NONE}

    # Determine if slider should be switched off
    _root = switch_slider(_encyclopedia.getroot(), _arg_switches)

    # Convert back to a string while preserving formatting
    _xml_string = etree.tostring(_root, encoding="utf-8", xml_declaration=False, pretty_print=True).decode()

    # Replace self-closing tags
    _xml_string = replace_self_closing_tags(_xml_string)

    # Save manually
    with open(_encyclopedia_file_path, "w", encoding="utf-8") as file:
        file.write(_xml_string)
