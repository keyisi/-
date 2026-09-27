// CLI 测试入口（仅 main.swift 允许顶层代码）
import Foundation
if CommandLine.arguments.count > 1 {
    // 集数自增测试模式
    if CommandLine.arguments.count == 3 && CommandLine.arguments[1] == "--ep" {
        if let r = incrementEpisode(CommandLine.arguments[2]) { print(r); exit(0) }
        print("NO_MATCH"); exit(2)
    }
    // 短剧整理助手 CLI: --cli <文件夹> "剧名" [选项] | --undo
    let a1 = CommandLine.arguments[1]
    if a1 == "--cli" || a1 == "--undo" {
        organizerCLI()
    }
    cliMain()
} else {
    print("用法: VideoPostCLI <视频> [-o 目录] [--step 1] [--jpg] [--quality 0.9] [--name 前缀]")
    print("     VideoPostCLI --ending <视频或目录...> [--cover 图片或封面目录] [--sfx 路径] [--fade-out 0.25] [--hold 0] [--fade-in 0.25] [--freeze 1] [--sfx-offset 0] [--afade 秒] [--suffix 后缀] [-o 目录] [--overwrite] [--print-cmd]  （--cover 为可选: 封面与结尾一次编码完成，目录则按集数自动匹配；--afade 原视频音频淡出时长，0=不淡化）")
    print("     VideoPostCLI --cli <文件夹> \"剧名\" [--organize] [--template T] [--pad N] [--out 目录] [--overwrite] [--execute] | --undo   （短剧整理助手）")
    exit(1)
}
