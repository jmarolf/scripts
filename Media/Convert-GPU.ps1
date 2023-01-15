param (
  [Parameter(Mandatory = $true)][string]$file
)

# TODO: add path to ffmpeg.exe on your system
$ffmpeg = "ffmpeg.exe"
$fileDirectory = [System.IO.Path]::GetFullPath([System.IO.Path]::GetDirectoryName("$file"))
$fileName = [System.IO.Path]::GetFileNameWithoutExtension("$file")
$outputFile = Join-Path $fileDirectory "$fileName.hevc.mkv"

# args explanation:
# -hwaccel cuda - use the GPU for decoding the input video file, we are encoding with the GPU so also loading the video into the GPU memory for decoding saves time
# -hwaccel_output_format cuda - output the decoded frames into the GPU memory, as long as we don't run out of GPU memory this will save time
# -extra_hw_frames 6 - allocate 6 extra frames in the GPU memory, this is GPU dependent, needed to avoid errors looking up data on the GPU
# -pix_fmt cuda - output the decoded frames in the GPU memory, run ffmpeg -h encoder=hevc_nvenc to see the supported pixel formats
# -c:a copy - copy the audio stream, we don't want to re-encode it
# -c:v hevc_nvenc - encode the video stream with the GPU
# -profile:v main10 - use the main10 profile, this enables 10 bit color depth which is a sweet spot for H.265 / HEVC
# -preset:v slow - use the slow preset, the slower the preset the better the compression with the same quality
# -tune:v hq - use the hq tune, prioritizes quality over encoding/decoding speed
& $ffmpeg -hwaccel cuda -hwaccel_output_format cuda -extra_hw_frames 6 -i "$file" -pix_fmt cuda -c:a copy -c:v hevc_nvenc -profile:v main10 -preset:v slow -tune:v hq "$outputFile"