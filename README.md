# PoshDirSize (PowerShell Directory Size) -  0.1.2WIP

<p align="center">
  <a href="https://github.com/Kinsiinoo/PoshDirSize"><img src="https://img.shields.io/github/languages/top/kinsiinoo/poshdirsize?style=for-the-badge"></a>
  <a href="https://github.com/Kinsiinoo/PoshDirSize"><img src="https://img.shields.io/github/languages/code-size/kinsiinoo/poshdirsize?style=for-the-badge"></a>
  <a href="https://github.com/Kinsiinoo/PoshDirSize"><img src="https://img.shields.io/github/license/kinsiinoo/poshdirsize?style=for-the-badge"></a>
</p>

<p align="center">
  <a href="https://github.com/Kinsiinoo/PoshDirSize/releases/"><img src="https://img.shields.io/github/v/release/kinsiinoo/poshdirsize?style=for-the-badge"></a>
  <a href="https://github.com/Kinsiinoo/PoshDirSize"><img src="https://img.shields.io/github/last-commit/kinsiinoo/poshdirsize?style=for-the-badge"></a>
</p>

This PowerShell module allow you to generate disk usage statistics.
The result will appear in the console and also in the `OUTPATH` folder as a `PoshDirSize_{yyyy-MM-dd-HH-mm-ss}.log` file.

## Screenshots

WIP

## Syntax

```PowerShell
Get-PoshDirSize [-PoshDSPath] <string> [-PoshDSOutPath] <string> [-PoshDSMode {Fast | Slow}] [-PoshDSFileInc <string>] [-PoshDSFileExc <string>] [-PoshDSDirInc <string>] [-PoshDSDirExc <string>]  [<CommonParameters>]
```

## Basic usage

```PowerShell
Get-PoshDirSize PATH OUTPATH
```

## Configuration

* `PoshDSMode` = Default value is always `Fast`.
  * `Fast`: Faster, but more resource intensive. (`foreach`)
  * `Slow`: Slower, but more resource efficient. (`ForEach-Object`)
* `PoshDSFileInc` = Include files based on name and file format.
  * Example: `*.log` or `DailyReport*.csv`
* `PoshDSFileExc` = Exclude files based on name and file format.
* `PoshDSDirInc` = Include dirs based on name.
  * Example: `System32` or `2022*Pics`
* `PoshDSDirExc` = Exclude dirs based on name.

### Advanced

* `$PoshDSRunTime` = You can configure the date format modifying the `yyyy-MM-dd-HH-mm-ss` section inside the module code.

## Todo

### Module

* [ ] Generate some kind of chart :chart::bar_chart:
* [ ] Faster file writer (.NET StreamWriter)
* [ ] Param: Switch for console output (enable/disable)
* [x] Param: OutPath
* [ ] Param: OutFile, multiple naming format
* [ ] Search: Minimum and maximum file size
* [X] Search: Include/exclude files based on name and file format
* [X] Search: Include/exclude dirs based on name
* [ ] Search: Depth
* [x] Search: Switch between fast/resource saving mode (partly done) :zap:/:deciduous_tree:
* [x] Refactor code into a nice PS module :eyes:

### Repo

* [ ] GitHub Actions
  * [ ] Version
  * [ ] Build
  * [ ] Test
  * [ ] Publish

## Changelog

### **v0.1.2 (WIP)**

* Set WindowsTitle at start
* Param: OutPath
* Search: Include/exclude files based on name and file format
* Search: Include/exclude dirs based on name

### v0.1.1

* Refactored into a PS module
* Added Fast/Slow mode (partly done)
* Added some verbose logging
* Escape special chars in path strings
* Added output mode to console and .log file

### Initial commit

* Basic functionality

## License

PoshDirSize is licensed under the MIT License.
