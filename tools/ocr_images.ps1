param(
    [string[]]$Paths,
    [switch]$Bounds
)

if (-not $Paths -or $Paths.Count -eq 0) {
    $Paths = Get-ChildItem -LiteralPath (Get-Location) -File -Filter '*.png' |
        Sort-Object Name |
        ForEach-Object { $_.FullName }
}

Add-Type -AssemblyName System.Runtime.WindowsRuntime
$null = [Windows.Storage.StorageFile, Windows.Storage, ContentType=WindowsRuntime]
$null = [Windows.Graphics.Imaging.BitmapDecoder, Windows.Graphics.Imaging, ContentType=WindowsRuntime]
$null = [Windows.Media.Ocr.OcrEngine, Windows.Foundation, ContentType=WindowsRuntime]

$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object {
    $_.Name -eq 'AsTask' -and
    $_.GetParameters().Count -eq 1 -and
    $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1'
})[0]

function Await-Result($operation, [Type]$resultType) {
    $asTask = $asTaskGeneric.MakeGenericMethod($resultType)
    $netTask = $asTask.Invoke($null, @($operation))
    $netTask.Wait(-1) | Out-Null
    return $netTask.Result
}

$engine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromUserProfileLanguages()
if ($null -eq $engine) {
    throw 'Windows OCR is not available for the current language.'
}

foreach ($path in $Paths) {
    $resolved = (Resolve-Path -LiteralPath $path).Path
    Write-Output "===== $([IO.Path]::GetFileName($resolved)) ====="
    $file = Await-Result ([Windows.Storage.StorageFile]::GetFileFromPathAsync($resolved)) ([Windows.Storage.StorageFile])
    $stream = Await-Result ($file.OpenAsync([Windows.Storage.FileAccessMode]::Read)) ([Windows.Storage.Streams.IRandomAccessStream])
    $decoder = Await-Result ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream)) ([Windows.Graphics.Imaging.BitmapDecoder])
    $transform = New-Object Windows.Graphics.Imaging.BitmapTransform
    $transform.ScaledWidth = [uint32]($decoder.PixelWidth * 2)
    $transform.ScaledHeight = [uint32]($decoder.PixelHeight * 2)
    $bitmap = Await-Result ($decoder.GetSoftwareBitmapAsync(
        [Windows.Graphics.Imaging.BitmapPixelFormat]::Bgra8,
        [Windows.Graphics.Imaging.BitmapAlphaMode]::Premultiplied,
        $transform,
        [Windows.Graphics.Imaging.ExifOrientationMode]::IgnoreExifOrientation,
        [Windows.Graphics.Imaging.ColorManagementMode]::DoNotColorManage
    )) ([Windows.Graphics.Imaging.SoftwareBitmap])
    $result = Await-Result ($engine.RecognizeAsync($bitmap)) ([Windows.Media.Ocr.OcrResult])
    foreach ($line in $result.Lines) {
        if ($Bounds -and $line.Words.Count -gt 0) {
            $minX = ($line.Words | ForEach-Object { $_.BoundingRect.X } | Measure-Object -Minimum).Minimum
            $minY = ($line.Words | ForEach-Object { $_.BoundingRect.Y } | Measure-Object -Minimum).Minimum
            $maxX = ($line.Words | ForEach-Object { $_.BoundingRect.X + $_.BoundingRect.Width } | Measure-Object -Maximum).Maximum
            $maxY = ($line.Words | ForEach-Object { $_.BoundingRect.Y + $_.BoundingRect.Height } | Measure-Object -Maximum).Maximum
            Write-Output ("[{0},{1},{2},{3}] {4}" -f [int]($minX/2), [int]($minY/2), [int](($maxX-$minX)/2), [int](($maxY-$minY)/2), $line.Text)
        } else {
            Write-Output $line.Text
        }
    }
    $stream.Dispose()
    $bitmap.Dispose()
}
