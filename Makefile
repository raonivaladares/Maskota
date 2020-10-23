.DEFAULT_GOAL := help
BUNDLE=$(if $(rbenv > /dev/null), rbenv exec bundle, bundle)
FASTLANE=$(BUNDLE) exec fastlane

test_unit: ## run unit tests
        $(FASTLANE) test_unit

release_alpha: ## builds the app using scheme and sends it to Test Flight
        $(FASTLANE) release_alpha
