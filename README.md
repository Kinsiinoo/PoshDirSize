# PoshDirSize

PowerShell Directory Size

This PowerShell script allow you to generate disk usage statistics.
The result will appear in the console and also in the newly created `C:\Temp\PoshDirSize\` folder as a `PoshDirSize_{yyyy-MM-dd-HH-mm-ss}.log` file.

## Screenshots

WIP

## Usage

You need to edit `$PoshDSPath` default value between the quotation marks.

## Configuration

* `$PoshDSPath` = Path of the folder waiting to be checked. Default value: `C:\`
* `$PoshDSOutPath` = Path of the output folder. Default value: `C:\Temp\PoshDirSize\`

### Advanced

* `$PoshDSRunTime` = You can configure the date format modifying the `yyyy-MM-dd-HH-mm-ss` section.

## Todo

* [ ] Switch between fast/resource saving mode :zap:/:deciduous_tree:
* [ ] Generate some kind of chart :chart::bar_chart:
* [ ] Refactor code into a nice PS module :eyes:

## License

PoshDirSize is licensed under the MIT License.
