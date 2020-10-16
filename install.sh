echo "downloading pandoc"
curl -LOJR https://github.com/jgm/pandoc/releases/download/2.10.1/pandoc-2.10.1-1-amd64.deb

echo "Installing pandoc"
sudo apt install ./pandoc*

echo "deleting pandoc installation file"
rm ./pandoc*

echo "Installing texlive"
sudo apt install texlive-latex-extra
