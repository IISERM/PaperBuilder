# Build tests
echo "Remove Old"
rm ./docs/test/report.pdf -ErrorAction Ignore
rm ./docs/test/assign.pdf -ErrorAction Ignore
rm ./docs/test/report_with_extra.pdf -ErrorAction Ignore
rm ./docs/test/assign_with_extra.pdf -ErrorAction Ignore
rm ./docs/test/report_with_extra.tex -ErrorAction Ignore
rm ./docs/test/assign_with_extra.tex -ErrorAction Ignore
echo "Removed Old"
echo "Building report"
mv (./src/PaperBuilder.py report ./docs/test) ./docs/test/report.pdf
echo "Building assign"
mv (./src/PaperBuilder.py assign ./docs/test) ./docs/test/assign.pdf
echo "Building report --e"
mv (./src/PaperBuilder.py report ./docs/test --e) ./docs/test/report_with_extra.pdf
echo "Building assign --e"
mv (./src/PaperBuilder.py assign ./docs/test --e) ./docs/test/assign_with_extra.pdf
echo "Building ltxreport"
mv (./src/PaperBuilder.py ltxreport ./docs/test) ./docs/test/report_with_extra.tex
echo "Building ltxassign"
mv (./src/PaperBuilder.py ltxassign ./docs/test) ./docs/test/assign_with_extra.tex
