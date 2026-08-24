# Plakoro Digital Move Cards

Plakoro Digital Move Cards 是實體 Plakoro 桌遊的數位招式卡與回合輔助工具。它沿用 Plakoro 專案的 Pokémon、招式卡、翻譯與原始圖片資料，讓玩家在 Windows、Linux 或 Web 介面中選擇招式、閱讀翻譯並記錄回合效果。

本工具不取代實體骰子與桌面判定，也不會自動計算完整戰鬥結果。玩家仍在桌面同時擲出 Enekoro 與 Charakoro；程式負責呈現卡片、記錄使用狀態並提醒特殊效果。

## 主要功能

- 從 Pokémon 招式池選擇正好四張招式卡。
- 同一物種的 A／B 實體卡版本會合併成單一 Pokémon 選項，招式池則合併顯示。
- 使用原始 Plakoro 招式卡背景、屬性 icon、Enekoro icon 與 Charakoro 骰面 icon。
- 招式卡支援點擊放大、取消與確認使用。
- Enekoro 與 Charakoro 同時擲出；先確認 Enekoro 是否滿足需求，成功後才判定同一次擲骰的 Charakoro 效果。
- Enekoro 不足時，招式失敗並忽略 Charakoro 效果。
- 上一個玩家回合使用過的招式，下一個玩家回合會鎖定一次。
- 特殊效果會記錄並在自己的下一回合或對手回合顯示提醒。
- HP 使用 `−10`／`+10` 手動調整；程式不會擅自套用傷害、回復、反傷或弱點加成。
- Pokémon 資訊會顯示 HP、屬性 icon、弱點 icon 與弱點加成。
- 支援 English、Español、日本語與繁體中文；切換語言時同步更新介面、名稱與效果內容。
- 內建 Noto Sans JP／TC 字體，避免 Web 版出現缺字方框。
- 支援 16:9～21:9 responsive layout，依視窗寬度自動調整欄數。

## 使用流程

### 1. 建立桌遊配置

1. 從左側選擇一隻 Pokémon。
2. 查看其 HP、屬性與弱點。
3. 從右側招式池勾選四張招式卡。
4. 招式摘要會顯示 Enekoro 需求、傷害、Charakoro 觸發骰面 icon 與對應效果。
5. 選滿四張後，按下「開始桌遊輔助」。

### 2. 玩家回合

1. 選擇一張未鎖定的招式卡。
2. 在放大卡片視窗確認內容，按「使用招式」。
3. 在實體桌面同時擲 Enekoro 與 Charakoro。
4. 若 Enekoro 不足，選擇招式失敗。
5. 若 Enekoro 成功，選擇同一次擲骰得到的 Charakoro 骰面。
6. 程式只記錄實際符合該骰面的效果，並進入對手回合。

### 3. 對手回合

1. 在實體桌面處理對手招式與所有效果。
2. 如有需要，使用 `−10`／`+10` 手動同步 Pokémon HP。
3. 查看目前生效的回合效果提醒。
4. 完成後按「對手回合結束」，進入下一個玩家回合。

### 4. 輔助資訊與結束遊戲

- 遊戲頁預設以招式卡為視覺重點。
- 使用「顯示資訊／隱藏資訊」切換 Pokémon、HP、弱點與最近骰面結果。
- 「結束遊戲」會回到 Pokémon 與四張招式卡的選擇畫面。

## Responsive layout

- 約 1280×720：選卡頁兩欄，遊戲頁四張卡以 2×2 呈現。
- 1600 px 以上：選卡頁使用三欄。
- 1500 px 以上且高度足夠：遊戲頁四張卡同列。
- 2400 px 以上：選卡頁使用四欄，充分利用 21:9 螢幕。
- 較窄畫面會退回一至兩欄；頁面與清單保留垂直捲動，避免操作區被裁切。
- 跨越 breakpoint 時會自動重排，已選招式不會因此清除。

## 資料與翻譯

```text
database/pokemon/        Pokémon 資料
database/move_cards/     招式卡與 Charakoro outcome 資料
language/content/        四語 Pokémon、招式與卡片效果翻譯
assets/pokemon/images/   Pokémon 圖片
assets/move_cards/       招式卡背景
assets/ui/energy/        屬性與 Enekoro icons
assets/ui/kyokoro/       Charakoro 骰面 icons
assets/fonts/            Noto Sans 字體與授權
```

翻譯查找會優先使用卡片專屬的 `move_card.<card_id>` 內容，再退回共用的 `move.<move_name_id>` 翻譯，以處理名稱相同但卡片效果不同的招式。

## 執行與匯出

1. 使用 Godot 4.7 或相容的 Godot 4.x 版本開啟 `project.godot`。
2. 執行主場景 `scenes/Main.tscn`。
3. 安裝相符版本的 export templates。
4. 使用內建 preset 匯出：

```text
Windows → build/windows/Plakoro_Digital_Move_Cards.exe
Linux   → build/linux/Plakoro_Digital_Move_Cards.x86_64
Web     → web/index.html
```

`build/`、`web/` 與 Godot 本機快取 `.godot/` 不納入 Git。

## 專案定位

這是一個 tabletop companion，而不是第二套自動戰鬥引擎。所有涉及實體桌面狀態的傷害、回復、弱點、防禦與特殊規則，應由玩家依實體遊戲結果判斷；數位工具的責任是讓招式卡更易讀、減少日文閱讀障礙，並避免玩家忘記跨回合效果。
