$org_root = "E:\51-photo\01-My-Pics\A86-PICS\Camera"
$dest_root = "E:\98-temp\99-a54\03-media"
$dest_media_root = ""
#$org_files = (Get-ChildItem $org_root | Select-Object -Property @{Name="FullPath"; Expression={$_.FullName}})
#echo $org_files
$org_files = (Get-ChildItem $org_root | Select-Object FullName)
foreach ($item in $org_files) {
    $date = (Get-Item $item.FullName).LastWriteTime | Get-Date -Format "yyyy-MM-dd"
    $media_type = (Get-Item $item.FullName).Extension
    Write-Host "path : "$item.FullName" , last write time : "$date" , media type : "$media_type

    if ($media_type -eq ".mp4") {
        $dest_media_root = "02-mov"
    } else {
        $dest_media_root = "01-photo"
    }

    $year = (Get-Item $item.FullName).LastWriteTime | Get-Date -Format "yyyy"
    $folderPath = $dest_root + "\" + $dest_media_root + "\" + $year
    if (Test-Path -Path $folderPath) {
        Write-Host "year is existed : "$folderPath
    } else {
        Write-Host "year is not existed : "$folderPath
        New-Item -Path $folderPath -ItemType Directory
    }
    
    $month = (Get-Item $item.FullName).LastWriteTime | Get-Date -Format "MM"
    $folderPath = $dest_root + "\" + $dest_media_root + "\" + $year + "\" + $month
    if (Test-Path -Path $folderPath) {
        Write-Host "month is existed : "$folderPath
    } else {
        Write-Host "month is not existed : "$folderPath
        New-Item -Path $folderPath -ItemType Directory
    }

    $day = (Get-Item $item.FullName).LastWriteTime | Get-Date -Format "dd"
    $folderPath = $dest_root + "\" + $dest_media_root + "\" + $year + "\" + $month + "\" + $day
    if (Test-Path -Path $folderPath) {
        Write-Host "day is existed : "$folderPath
    } else {
        Write-Host "day is not existed : "$folderPath
        New-Item -Path $folderPath -ItemType Directory
    }

    if (Test-Path -Path $folderPath) {
        Move-Item -Path $item.FullName -Destination $folderPath
    }
}
#pause