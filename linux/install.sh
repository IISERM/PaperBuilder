echo "Updating packages"
sudo apt update
sudo apt upgrade -y
sudo apt autoclean

echo "Installing Pre Requisites..."

mkdir -p ~/.paperbuilder/temp

echo "  Pandoc"
echo "    Downloading..."
curl -#L https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-1-amd64.deb -o ~/.paperbuilder/temp/pandoc.deb

echo "    Installing..."
sudo apt install ~/.paperbuilder/temp/pandoc.deb

echo "  Installing texlive"
sudo apt install texlive-latex-extra

echo "  Installing python3"
sudo apt install python3

echo "Installing PaperBuilder"
echo "  Downloading files..."
curl -#L https://github.com/IISERM/PaperBuilder/releases/download/{version}/source-files.tar.gz -o ~/.paperbuilder/temp/source-files.tar.gz

echo "  Extracting files..."
tar -xzf ~/.paperbuilder/temp/source-files.tar.gz -C ~/.paperbuilder

echo "  Adding pprb alias to ~/.bashrc"
echo "alias pprb=~/.paperbuilder/src/PaperBuilder.py" >> ~/.bashrc

echo "  Deleting temp files"
rm -r ~/.paperbuilder/temp

echo "DONE!"
echo "run 'source ~/.bashrc' and then 'pprb' to start"
