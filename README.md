# PoshDirSize

PowerShell Directory Size 0.1.1

This PowerShell script allow you to generate disk usage statistics.
The result will appear in the console and also in the newly created `C:\Temp\PoshDirSize\` folder as a `PoshDirSize_{yyyy-MM-dd-HH-mm-ss}.log` file.

## Screenshots

WIP

## Syntax

```PowerShell
Get-PoshDirSize [-PoshDSPath] <string> [[-PoshDSMode] {Fast | Slow}]  [<CommonParameters>]
```

## Usage

```PowerShell
Get-PoshDirSize PATH (MODE)
```

Mode is optional, but the default value is always `Fast`.

Modes:

* `Fast`: Faster, but more resource intensive.
* `Slow`: Slower, but more resource efficient.

## Configuration

* `$PoshDSOutPath` = Path of the output folder. Default value: `C:\Temp\PoshDirSize\`

### Advanced

* `$PoshDSRunTime` = You can configure the date format modifying the `yyyy-MM-dd-HH-mm-ss` section.

## Todo

* [x] Switch between fast/resource saving mode :zap:/:deciduous_tree:
* [ ] Generate some kind of chart :chart::bar_chart:
* [x] Refactor code into a nice PS module :eyes:

## License

PoshDirSize is licensed under the MIT License.
