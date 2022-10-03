#写轮眼辅助
.\bin\ffmpeg.exe -i demo.mp4 -vf "movie=mark.png[watermark];[in][watermark] overlay=main_w/2-overlay_w/2:main_h-overlay_h-10[out]" mark.mp4

#将demo.mp4切去前面30毫秒, 输出到short.mp4 。短片抽30毫秒合适,3D效果强, 电视剧则适合20毫秒
.\bin\ffmpeg.exe -ss 00:00:00.030 -i mark.mp4 -vcodec copy -acodec copy short.mp4
#.\bin\ffmpeg.exe -ss 00:00:00.020 -i mark.mp4 -vcodec copy -acodec copy short.mp4

# 删除垃圾文件
del out.mp4

#合并demo.mp4 short.mp4,一左一右生成3D视角
.\bin\ffmpeg.exe -i mark.mp4 -vf  "movie=short.mp4 [in1]; [in]pad=iw*2:ih:iw:0[in0]; [in0][in1] overlay=0:0 [out]" -vcodec libx264 -preset medium -b:v 1200k -r:v 25 -f mp4 out.mp4

# 删除垃圾文件
del mark.mp4
del short.mp4

pause