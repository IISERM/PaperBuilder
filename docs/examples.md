# Examples

This is the template Markdown file which is compiled using PaperBuilder.

| Build Type                                                                          | Command                        |
| ----------------------------------------------------------------------------------- | ------------------------------ |
| <a href="#pdfviewer" onclick="setpdf('report.pdf')">Report</a>                      | `PaperBuilder report test`     |
| <a href="#pdfviewer" onclick="setpdf('assign.pdf')">Assignment</a>                  | `PaperBuilder assign test`     |
| <a href="#pdfviewer" onclick="setpdf('report_with_extra.pdf')">Report Extra</a>     | `PaperBuilder report test --e` |
| <a href="#pdfviewer" onclick="setpdf('assign_with_extra.pdf')">Assignment Extra</a> | `PaperBuilder assign test --e` |
| [Report Latex](./test/report.tex)                                                   | `PaperBuilder ltxreport test`  |
| [Assignment Latex](./test/assign.tex)                                               | `PaperBuilder ltxassign test`  |

<embed id="pdfviewer" src="./test/report.pdf" type="application/pdf" width="100%" height=750px>

<script>
    function setpdf(name) {
        document.getElementById("pdfviewer").src = "./test/"+name
    }
</script>
