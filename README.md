# PoshDirSize

PowerShell Directory Size

This PowerShell script allow you to generate disk usage statistics.
The result will appear in the console and also in the newly created `C:\Temp\PoshDirSize\` folder as a `PoshDirSize_{yyyy-MM-dd-HH-mm-ss}.log` file.

## Usage

You need to edit `$PoshDSPath` default value between the quotation marks.

## Configuration

* `$PoshDSPath` = Path of the folder waiting to be checked. Default value: `C:\`
* `$PoshDSOutPath` = Path of the output folder. Default value: `C:\Temp\PoshDirSize\`
* `$PoshDSRunTime` = You can configure the date format modifying the `yyyy-MM-dd-HH-mm-ss` section.

## License

PoshDirSize is licensed under the MIT License.
