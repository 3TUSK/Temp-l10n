echo "Package assembling, please stand by..."
zip -r TemporaryLocalization-UnofficialVersion-$(date +"%Y-%m-%d-%T").zip assets CREDIT README.md pack.mcmeta pack.png
echo "Package created."
