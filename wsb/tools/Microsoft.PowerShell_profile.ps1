C:\venv\Scripts\Activate.ps1

# Use git to diff to files
function Diff-TwoFiles ($file1, $file2) {
    git diff $file1 $file2
}
Set-Alias gdiff Diff-TwoFiles

# Make Windows be more like Linux :)
Set-Alias less more
