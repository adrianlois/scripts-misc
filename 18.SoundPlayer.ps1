$Audio = New-Object System.Media.SoundPlayer
$Audio.SoundLocation = "C:\temp\media\sound.wav"
# Play once
$Audio.Play()
# Play loop
$Audio.PlayLooping()
# Stop play
$Audio.Stop()