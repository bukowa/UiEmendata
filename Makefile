# Mod package information
MOD_PACKAGE ?= uiemendata.pack

# ============================================================
# Instructions for Executing This Makefile on Windows
# ============================================================
#
# 1. Install GNU Make for Windows:
#    - Download it from:
#      https://sourceforge.net/projects/gnuwin32/files/make/3.81/make-3.81-bin.zip/download
#
# 2. Install Git for Windows (which includes Git Bash):
#    - Download it from:
#      https://git-scm.com/downloads/win
#
# 3. Update Your System PATH:
#    - After installing GNU Make, add its installation directory (where make.exe is located)
#      to your system's PATH environment variable.
#
# 4. Running the Makefile:
#    - Open the Git Bash shell.
#    - Navigate to the directory containing this Makefile.
#    - Execute the command: `make setup`
#
# Note:
# This Makefile has been designed and tested for use with GNU Make in the Git Bash shell.
# ============================================================

# Directories for dependencies and build files
BUILD_DIR         := ./build
SOURCE_DIR        := src
DEPS_DIR		  := ./.deps
RPFM_SCHEMA_DIR   := $(DEPS_DIR)/rpfm_schema
RPFM_CLI_DIR      := $(DEPS_DIR)/rpfm_cli
ETWNG_DIR         := $(DEPS_DIR)/etwng
RUBY_DIR          := $(DEPS_DIR)/ruby
LDOC_DIR 		  := $(DEPS_DIR)/ldoc
MAKE_DIR          := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

# Binaries and paths
RUBY_BIN          := $(RUBY_DIR)/bin/ruby.exe
RPFM_CLI_BIN      := $(RPFM_CLI_DIR)/rpfm_cli
XML2UI_BIN        := $(ETWNG_DIR)/ui/bin/xml2ui
UI2XML_BIN        := $(ETWNG_DIR)/ui/bin/ui2xml
RPFM_SCHEMA_PATH  := $(RPFM_SCHEMA_DIR)/schema_rom2.ron
RPFM_CLI_ROME2_CMD := $(realpath $(RPFM_CLI_BIN)) --game rome_2
LUA_FOR_LDOC_PATH := "C:\Program Files (x86)\Lua\5.1\lua.exe"

# rpfm_cli details
RPFM_CLI_VERSION       := v4.3.14
RPFM_CLI_BASE_URL      := https://github.com/Frodo45127/rpfm/releases/download
RPFM_CLI_DOWNLOAD_URL  := $(RPFM_CLI_BASE_URL)/$(RPFM_CLI_VERSION)/rpfm-$(RPFM_CLI_VERSION)-x86_64-pc-windows-msvc.zip

# Ruby details
RUBY_VERSION          := 3.4.2-1
RUBY_DOWNLOAD_URL     := https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-$(RUBY_VERSION)/rubyinstaller-$(RUBY_VERSION)-x64.7z
RUBY_EXTRACTED_DIR    := $(RUBY_DIR)/rubyinstaller-$(RUBY_VERSION)-x64

# 7-Zip details
SEVENZIP_DOWNLOAD_URL := https://www.7-zip.org/a/7za920.zip
SEVENZIP_DIR          := $(DEPS_DIR)/7zip
SEVENZIP_BIN          := $(SEVENZIP_DIR)/7za.exe

# ETWNG repository details
ETWNG_REPO     = https://github.com/taw/etwng.git
ETWNG_REVISION = f87f7c9e21ff8f0ee7cdf466368db8a0aee19f23

# ldoc details
LDOC_REPO     = "https://github.com/lunarmodules/ldoc.git"
LDOC_REVISION = "f91ed4b76bec011a2e76cfe1283877686af8377e"

# Installation directories
INSTALL_ALONE_DIR := C:/Games/Total War - Rome 2
INSTALL_STEAM_DIR := C:/Program Files (x86)/Steam/steamapps/common/Total War Rome II
INSTALL_USER_SCRIPT := C:/Users/$(USERNAME)/AppData/Roaming/The\ Creative\ Assembly/Rome2/scripts

# ============================================================
# Start Source Files
# ============================================================
UI_TARGETS ?=
#	$(BUILD_DIR)/ui/frontend\ ui/sp_grand_campaign \
#	$(BUILD_DIR)/ui/campaign\ ui/pre_battle_post_battle \
#	$(BUILD_DIR)/ui/campaign\ ui/units_panel \
	$(BUILD_DIR)/ui/common\ ui/land_unit_card
#	$(BUILD_DIR)/ui/common\ ui/encyclopedia_building_info_template \
#	$(BUILD_DIR)/ui/common\ ui/encyclopedia_unit_info_template \


LUA_TARGETS :=

IMAGE_TARGETS :=

CONTRIB_TARGETS :=

SWITCH := 0

ifneq ($(FLAG),)
  ifeq ($(FLAG),unit_category_icon_off)
    MOD_PACKAGE := unit_category_icon_off.pack
    SOURCE_DIR := src/unit_category_icon_off
    UI_TARGETS := \
    	$(BUILD_DIR)/ui/common\ ui/land_unit_card \
    	$(BUILD_DIR)/ui/common\ ui/3c/land_unit_card
    LUA_TARGETS :=
    IMAGE_TARGETS :=
    CONTRIB_TARGETS :=
  endif
  # menu_sp_grand_campaign_fix
  ifeq ($(FLAG),menu_sp_grand_campaign_fix)
    MOD_PACKAGE := menu_sp_grand_campaign_fix.pack
    SOURCE_DIR := src/menu_sp_grand_campaign_fix
    UI_TARGETS := $(BUILD_DIR)/ui/frontend\ ui/sp_grand_campaign
    LUA_TARGETS :=
    IMAGE_TARGETS :=
    CONTRIB_TARGETS :=
  endif

  # encyclopedia_building_info_template_fix
  ifeq ($(FLAG),uiemendata_enc_building_fix)
    MOD_PACKAGE := uiemendata_enc_building_fix.pack
    SOURCE_DIR := src/uiemendata_enc_building_fix
    UI_TARGETS := \
    	$(BUILD_DIR)/ui/common\ ui/encyclopedia_building_info_template
    LUA_TARGETS :=
    IMAGE_TARGETS :=
    CONTRIB_TARGETS :=
  endif

  # unit_card_backgrounds_transparent
  ifeq ($(FLAG),dei_bukowa_unitcards)
    MOD_PACKAGE := dei_bukowa_unitcards.pack
    SOURCE_DIR := src/dei_bukowa_unitcards
    UI_TARGETS := \
    	$(BUILD_DIR)/ui/common\ ui/land_unit_card \
    	$(BUILD_DIR)/ui/loading_ui/battle \
    	$(BUILD_DIR)/ui/loading_ui/postbattle \
    	$(BUILD_DIR)/ui/campaign\ ui/pre_battle_post_battle

    LUA_TARGETS :=
	IMAGE_TARGETS := \
		$(BUILD_DIR)/ui/skins/default/ee_button_text_frame.png \
		$(BUILD_DIR)/ui/skins/default/unit_card_frame.png \
		$(BUILD_DIR)/ui/skins/default/unit_card_frame_background.png \
		$(BUILD_DIR)/ui/skins/default/ee_unit_card_frame_background.png \
		$(BUILD_DIR)/ui/skins/default/unit_card_border.png \
		$(BUILD_DIR)/ui/skins/default/button_basic_glow.png \
		$(BUILD_DIR)/ui/skins/3c_DeI/unit_card_frame_background.png \
		$(BUILD_DIR)/ui/skins/3c_DeI/ee_unit_card_frame_background.png \
		$(BUILD_DIR)/ui/skins/3c_DeI/unit_card_frame.png
#		$(BUILD_DIR)/ui/skins/default/stat_bar_blue.png \
    CONTRIB_TARGETS :=
  endif

  ifeq ($(FLAG),dei_pre_battle_post_battle_20)
    MOD_PACKAGE := dei_pre_battle_post_battle_20.pack
    SOURCE_DIR := src/dei_pre_battle_post_battle_20
    UI_TARGETS := \
    	$(BUILD_DIR)/ui/campaign\ ui/pre_battle_post_battle
    LUA_TARGETS :=
	IMAGE_TARGETS :=
  endif

  ifeq ($(FLAG),dei_pre_battle_post_battle_40)
    MOD_PACKAGE := dei_pre_battle_post_battle_40.pack
    SOURCE_DIR := src/dei_pre_battle_post_battle_40
    UI_TARGETS := \
    	$(BUILD_DIR)/ui/campaign\ ui/pre_battle_post_battle
    LUA_TARGETS :=
	IMAGE_TARGETS :=
  endif

  ifeq ($(FLAG),dei_units_panel_40)
    MOD_PACKAGE := dei_units_panel_40.pack
    SOURCE_DIR := src/dei_units_panel_40
    UI_TARGETS := \
    	$(BUILD_DIR)/ui/campaign\ ui/units_panel
    LUA_TARGETS :=
	IMAGE_TARGETS :=
  endif

  ifeq ($(FLAG),uiemendata_loading_battle_postbattle)
    MOD_PACKAGE := uiemendata_loading_battle_postbattle.pack
    SOURCE_DIR := src/uiemendata_loading_battle_postbattle
    UI_TARGETS := \
    	$(BUILD_DIR)/ui/loading_ui/battle \
    	$(BUILD_DIR)/ui/loading_ui/postbattle
    LUA_TARGETS :=
	IMAGE_TARGETS :=
    CONTRIB_TARGETS :=
  endif

endif

# Rule for creating the mod package with rpfm_cli
$(MOD_PACKAGE): $(UI_TARGETS) $(LUA_TARGETS) $(CONTRIB_TARGETS) $(IMAGE_TARGETS)
	@{ \
	  ${RPFM_CLI_ROME2_CMD} pack create --pack-path=$@ && \
	  ${RPFM_CLI_ROME2_CMD} pack add --pack-path=$@ -F './$(BUILD_DIR)/;' -t ${RPFM_SCHEMA_PATH} && \
	  echo "Pack file built successfully." ; \
	} || { rm $@; exit 1; }

define create_dir
	@mkdir -p $(dir $@)
endef

#$(BUILD_DIR)/%.png: $(SOURCE_DIR)/%.png
#	$(create_dir)
#	cp "$<" "$@"

$(BUILD_DIR)/ui/skins/default/%.png: $(SOURCE_DIR)/ui/skins/default/%.png
	$(create_dir)
	cp "$<" "$@"

$(BUILD_DIR)/ui/skins/3c/%.png: $(SOURCE_DIR)/ui/skins/3c/%.png
	$(create_dir)
	cp "$<" "$@"

$(BUILD_DIR)/ui/skins/3c_DeI/%.png: $(SOURCE_DIR)/ui/skins/3c_DeI/%.png
	$(create_dir)
	cp "$<" "$@"

$(BUILD_DIR)/ui/common\ ui/encyclopedia_building_info_template: \
	$(SOURCE_DIR)/ui/common\ ui/encyclopedia_building_info_template.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/common\ ui/3c/encyclopedia_building_info_template: \
	$(SOURCE_DIR)/ui/common\ ui/3c/encyclopedia_building_info_template.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/common\ ui/encyclopedia_unit_info_template: \
	$(SOURCE_DIR)/ui/common\ ui/encyclopedia_unit_info_template.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/campaign\ ui/clan: \
	$(SOURCE_DIR)/ui/campaign\ ui/clan.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/campaign\ ui/building_info_generic_entry: \
	$(SOURCE_DIR)/ui/campaign\ ui/building_info_generic_entry.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/campaign\ ui/building_info_recruitment_effects: \
	$(SOURCE_DIR)/ui/campaign\ ui/building_info_recruitment_effects.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/frontend\ ui/sp_grand_campaign: \
	$(SOURCE_DIR)/ui/frontend\ ui/sp_grand_campaign.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/campaign\ ui/pre_battle_post_battle: \
	$(SOURCE_DIR)/ui/campaign\ ui/pre_battle_post_battle.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/campaign\ ui/layout: \
	$(SOURCE_DIR)/ui/campaign\ ui/layout.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/campaign\ ui/units_panel: \
	$(SOURCE_DIR)/ui/campaign\ ui/units_panel.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/common\ ui/land_unit_card: \
	$(SOURCE_DIR)/ui/common\ ui/land_unit_card.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/common\ ui/3c/land_unit_card: \
	$(SOURCE_DIR)/ui/common\ ui/3c/land_unit_card.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/loading_ui/battle: \
	$(SOURCE_DIR)/ui/loading_ui/battle.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/loading_ui/postbattle: \
	$(SOURCE_DIR)/ui/loading_ui/postbattle.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

$(BUILD_DIR)/ui/campaign\ ui/events: \
	$(SOURCE_DIR)/ui/campaign\ ui/events.xml
	$(create_dir)
	$(XML2UI_BIN) "$<" "$@"

# ============================================================
# End Source Files
# ============================================================

# Cleaning up all build artifacts and generated mod packages
clean:
	@rm -rf $(BUILD_DIR)
	@rm -f $(MOD_PACKAGE)
	@rm -f $(INSTALL_ALONE_DIR)/data/$(MOD_PACKAGE)
	@rm -f '$(INSTALL_STEAM_DIR)/data/$(MOD_PACKAGE)'
	@echo "Cleaned up build directory and mod package."

# Setup target to prepare all necessary dependencies
setup: \
	setup-rpfm_cli \
	setup-rpfm_schema \
	setup-etwng \
	setup-7zip \
	setup-ruby \
	setup-ldoc
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(ETWNG_DIR)
	@mkdir -p $(RPFM_CLI_DIR)
	@mkdir -p $(RPFM_SCHEMA_DIR)
	@echo "Setup complete, all dependencies are ready."

# Rule for setting up rpfm_cli
setup-rpfm_cli:
	@if [ ! -f $(RPFM_CLI_BIN) ]; then \
		echo "rpfm_cli not found, downloading:" && \
		echo "${RPFM_CLI_DOWNLOAD_URL}" && \
		mkdir -p $(RPFM_CLI_DIR) && \
		curl -sL $(RPFM_CLI_DOWNLOAD_URL) -o $(RPFM_CLI_DIR)/rpfm_cli.zip && \
		echo "unzipping rpfm_cli..." && \
		unzip -q $(RPFM_CLI_DIR)/rpfm_cli.zip -d $(RPFM_CLI_DIR) && \
		rm $(RPFM_CLI_DIR)/rpfm_cli.zip && \
		echo "rpfm_cli has been downloaded and extracted."; \
	fi

# Rule for setting up rpfm schema
setup-rpfm_schema: setup-rpfm_cli
	@if [ ! -f "$(RPFM_SCHEMA_PATH)" ]; then \
		echo "rpfm schema not found, updating..." && \
		mkdir -p "$(RPFM_SCHEMA_DIR)" && \
		echo "changing directory to $(RPFM_SCHEMA_DIR) to update schema..." && \
		echo "$(RPFM_CLI_ROME2_CMD) schemas update --schema-path ./" && \
		( cd "$(RPFM_SCHEMA_DIR)" && $(RPFM_CLI_ROME2_CMD) schemas update --schema-path ./ ) && \
		echo "Schema update complete."; \
	fi

# Rule for setting up ETWNG (requires Ruby)
setup-etwng: setup-ruby
	@if [ ! -f $(XML2UI_BIN) ]; then \
		echo "etwng not found, cloning..." && \
		mkdir -p $(ETWNG_DIR) && \
		git clone --depth 1 $(ETWNG_REPO) $(ETWNG_DIR) && \
		cd $(ETWNG_DIR) && \
		git checkout -q $(ETWNG_REVISION) && \
		echo "Checked out to specific revision."; \
	fi

# Rule for setting up 7-Zip
setup-7zip:
	@if [ ! -f "$(SEVENZIP_BIN)" ]; then \
		echo "7zip not found, downloading..." && \
		mkdir -p $(SEVENZIP_DIR) && \
		curl -sL $(SEVENZIP_DOWNLOAD_URL) -o $(SEVENZIP_DIR)/7za920.zip && \
		echo "unzipping 7zip..." && \
		powershell -Command "Expand-Archive -Path $(SEVENZIP_DIR)/7za920.zip -DestinationPath $(SEVENZIP_DIR)" && \
		rm $(SEVENZIP_DIR)/7za920.zip && \
		echo "7zip has been downloaded and extracted."; \
	fi

# Rule for setting up Ruby (requires 7-Zip)
setup-ruby: setup-7zip
	@if [ ! -f "$(RUBY_DIR)/bin/ruby" ]; then \
		echo "ruby not found, downloading ..." && \
		echo $(RUBY_DOWNLOAD_URL) && \
		mkdir -p $(RUBY_DIR) && \
		curl -sL $(RUBY_DOWNLOAD_URL) -o $(RUBY_DIR)/ruby.7z && \
		echo "unzipping ruby..." && \
		$(SEVENZIP_DIR)/7za x $(RUBY_DIR)/ruby.7z -o$(RUBY_DIR) -y && \
		mv -f $(RUBY_EXTRACTED_DIR)/* $(RUBY_DIR) && \
		rm -rf $(RUBY_EXTRACTED_DIR) && \
		rm $(RUBY_DIR)/ruby.7z && \
		echo "Ruby version $(RUBY_VERSION) has been downloaded and extracted."; \
	fi

# Rule for setting up ldoc
setup-ldoc:
	@if [ ! -f "$(LDOC_DIR)/ldoc/doc.lua" ]; then \
		echo "ldoc not found, cloning..." && \
		mkdir -p $(LDOC_DIR) && \
		git clone --depth 1 $(LDOC_REPO) $(LDOC_DIR) && \
		cd $(LDOC_DIR) && \
		git checkout -q $(LDOC_REVISION) && \
		echo "Checked out to specific revision."; \
	fi

# Rule for generating documentation
generate-docs: setup-ldoc
	@echo "Generating documentation..."
	$(LUA_FOR_LDOC_PATH) $(LDOC_DIR)/ldoc/doc.lua $(MAKE_DIR)src/consul

# Install Steam and alone
install: \
	install-alone \
	install-steam

# Install the built .pack file only if different for Steam
install-steam: $(MOD_PACKAGE)
	$(call install-to-dir,$(INSTALL_STEAM_DIR)/data)

# Install the built .pack file only if different for standalone
install-alone: $(MOD_PACKAGE)
	rm $(INSTALL_USER_SCRIPT)/user.script.txt
	echo 'show_frontend_movies false;' > $(INSTALL_USER_SCRIPT)/user.script.txt
	#echo 'game_startup_mode campaign_load "Quick Save.save";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	echo 'mod "$(MOD_PACKAGE)";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	echo 'mod "_helper_encyclopedia_building_info_template.pack";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	echo 'mod "consulscriptum.pack";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	$(call install-to-dir,$(INSTALL_ALONE_DIR)/data)

# Install with DEI
install-dei: $(MOD_PACKAGE)
	rm $(INSTALL_USER_SCRIPT)/user.script.txt
	@echo 'show_frontend_movies false;' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	@#echo 'game_startup_mode campaign_load "dei_battle_40.save";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	@echo 'mod "$(MOD_PACKAGE)";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	@echo 'mod "consulscriptum.pack";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	@#echo 'mod "models_extravaganza_v1_part1_0.pack";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	@#echo 'mod "@@@@deilegionsMARCSUM.pack";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	@echo 'mod "_divide_et_impera_release_12_Part1.pack";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	@echo 'mod "_divide_et_impera_release_12_Part2.pack";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	@#echo 'mod "Campaign_Performance_Patch.pack";' >> $(INSTALL_USER_SCRIPT)/user.script.txt
	$(call install-to-dir,$(INSTALL_ALONE_DIR)/data)

# Function to install the mod package to a specified directory
install-to-dir = \
	@if [ ! -f "$1/$(MOD_PACKAGE)" ] || ! cmp -s "$<" "$1/$(MOD_PACKAGE)"; then \
		cp "$<" "$1/$(MOD_PACKAGE)" && \
		echo "Mod package installed successfully to $1"; \
	fi

# Attempt to find and terminate the Rome 2 process by its name.
kill-rome2:
	@pid=$$(tasklist | grep Rome2.exe | head -n 1 | awk '{print $$2}') && \
	if [ -n "$$pid" ]; then \
		cmd //C "taskkill /F /PID $$pid" && \
		while tasklist | grep -q $$pid; do sleep 1; done; \
	fi

define disable_outdated_mods_popup
	powershell -Command Start-Process ./scripts/disable_outdated_mods_popup.bat
endef

# Launch the standalone version of Rome2.exe with the specified working directory
run-alone: \
	kill-rome2 \
	install-alone
	@$(disable_outdated_mods_popup)
	@powershell -Command Start-Process "Rome2.exe" -WorkingDirectory '"$(INSTALL_ALONE_DIR)"'

# Launch the standalone without mods
run-standalone: kill-rome2
	@$(disable_outdated_mods_popup)
	@echo '' > $(INSTALL_USER_SCRIPT)/user.script.txt
	@powershell -Command Start-Process "Rome2.exe" -WorkingDirectory '"$(INSTALL_ALONE_DIR)"'

# Launch the alone with DEI
run-alone-dei: \
	kill-rome2 \
	install-dei
	@$(disable_outdated_mods_popup)
	@powershell -Command Start-Process "Rome2.exe" -WorkingDirectory '"$(INSTALL_ALONE_DIR)"'

# Launch the Steam version of Rome2 using its Steam app ID
run-steam: \
	kill-rome2 \
	install-steam
	@$(disable_outdated_mods_popup)
	@powershell -Command start steam://rungameid/214950


# short aliases for the run targets
alone: run-alone

# Its strongly suggested to run steam in offline mode due to various bugs/
steam: run-steam

# Commands used to insert new Consul entry into the xml ui files
# We need to use XML2UI_BIN to convert the xml files to ui files and then back to xml files
# and then delete them
insert-consul-entry:
	python ./scripts/insert_consul_entry.py $(ARGS)
	$(XML2UI_BIN) ./src/ui/frontend\ ui/sp_frame.xml ./src/ui/frontend\ ui/sp_frame
	$(XML2UI_BIN) ./src/ui/common\ ui/menu_bar.xml ./src/ui/common\ ui/menu_bar
	$(UI2XML_BIN) ./src/ui/frontend\ ui/sp_frame ./src/ui/frontend\ ui/sp_frame.xml
	$(UI2XML_BIN) ./src/ui/common\ ui/menu_bar ./src/ui/common\ ui/menu_bar.xml
	rm ./src/ui/frontend\ ui/sp_frame
	rm ./src/ui/common\ ui/menu_bar

# Declare phony targets to prevent conflicts with file names
.PHONY: setup \
			setup-7zip \
			setup-rpfm_cli \
			setup-rpfm_schema \
			setup-ruby \
			setup-etwng \
		install \
			install-steam \
			install-alone \
		kill-rome \
		run-alone \
		run-steam \
		steam \
		alone \
		clean
