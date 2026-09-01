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
- 可選擇完全離線的桌遊輔助，或透過六位房間碼連接兩台手機。
- 線上模式支援擲硬幣或猜拳決定先攻，並在雙方準備完成後同步開戰。
- 對手確認出招後，手機會以目前語言顯示對手的完整招式卡、傷害與觸發效果。

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

### 5. 離線與線上對戰

- **離線**：不需要伺服器或網路，直接選擇四張卡並開始；對手回合完成後手動按下「對手回合結束」。
- **線上**：按下「連線」，一方建立房間，另一方輸入六位房間碼。
- 兩台手機連線後，可以擲硬幣或雙方猜拳決定先攻；猜拳平手時需重新選擇。
- 兩位玩家各自選擇 Pokémon 與四張卡，雙方都按下「準備完成」後才會進入戰鬥。
- 出招方完成 Enekoro 與 Charakoro 判定後，對手手機會自動顯示招式卡、傷害、弱點提示、自傷、回復、減傷、免傷與觸發效果。
- 連線失敗不會影響離線模式；斷開連線後仍可回到原本的手動桌遊流程。

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

---

# English Manual

Plakoro Digital Move Cards is a digital move-card viewer and turn companion for the physical Plakoro tabletop game. It reuses the Pokémon, move-card, localization, and original image data from the Plakoro project, allowing players to select moves, read translated cards, and track turn effects on Windows, Linux, or the Web.

This application does not replace the physical dice or tabletop rulings, and it does not calculate an entire battle automatically. Players still roll Enekoro and Charakoro together on the physical table. The application presents the cards, records move usage, and reminds players about special effects.

## Key features

- Select exactly four move cards from a Pokémon's available move pool.
- Physical A/B card variants of the same species are merged into one Pokémon option, while their move pools are combined.
- Uses the original Plakoro move-card background, type icons, Enekoro icons, and Charakoro face icons.
- Move cards can be opened in a larger view, cancelled, or confirmed for use.
- Enekoro and Charakoro are rolled together. The Enekoro requirement is checked first; only a successful move can trigger the Charakoro effect from the same roll.
- If the Enekoro result is insufficient, the move fails and its Charakoro effect is ignored.
- A move used during the previous player turn is locked for the next player turn.
- Special effects are recorded and shown as reminders during the relevant player or opponent turn.
- HP is adjusted manually with `−10` and `+10`. The application does not automatically apply damage, healing, recoil, or Weakness bonuses.
- Pokémon information includes HP, a type icon, a Weakness icon, and the Weakness damage bonus.
- Supports English, Spanish, Japanese, and Traditional Chinese. Changing the language updates the interface, Pokémon names, move names, and effect text.
- Bundles Noto Sans JP and Noto Sans TC to prevent missing CJK glyphs in Web exports.
- Supports responsive layouts from 16:9 through 21:9, automatically adjusting the number of columns to the viewport.
- Supports either a fully offline tabletop flow or a two-phone connection using a six-character room code.
- Online rooms can use a server-side coin flip or private rock-paper-scissors to decide who goes first, then wait until both players are ready.
- When an opponent confirms a move, the receiving phone displays the full card, damage, and triggered effects in its currently selected language.

## How to use

### 1. Create a tabletop loadout

1. Select one Pokémon from the list on the left.
2. Review its HP, type, and Weakness.
3. Select four move cards from the move pool on the right.
4. Each summary shows its Enekoro requirement, damage, Charakoro trigger-face icons, and the corresponding effects.
5. After selecting four cards, press **Start Tabletop Session**.

### 2. Player turn

1. Select an unlocked move card.
2. Review the enlarged card and press **Use Move**.
3. Roll Enekoro and Charakoro together on the physical table.
4. If the Enekoro result is insufficient, choose the move-failed option.
5. If the Enekoro result succeeds, select the Charakoro face produced by the same roll.
6. The application records only the effect matching that face, then advances to the opponent turn.

### 3. Opponent turn

1. Resolve the opponent's move and effects on the physical table.
2. Use `−10` or `+10` to synchronize the Pokémon's HP when necessary.
3. Review any active turn-effect reminders.
4. Press **Opponent Turn Finished** to begin the next player turn.

### 4. Optional information and ending a game

- The play screen keeps the move cards as its primary visual focus.
- Use **Show info / Hide info** to toggle Pokémon details, HP, Weakness, and the most recent dice result.
- **End Game** returns to the Pokémon and four-card selection screen.

### 5. Offline and online play

- **Offline:** no server or network is required. Select four cards and start immediately, then press **Opponent Turn Finished** after resolving the physical opponent turn.
- **Online:** press **Connect**. One player creates a room and the other enters its six-character room code.
- After both phones connect, use a coin flip or private rock-paper-scissors to decide initiative. A tied RPS round is repeated.
- Each player selects a Pokémon and four cards independently. Battle begins only after both players press **Ready**.
- After the acting player confirms Enekoro and Charakoro, the opponent receives the move card, damage, Weakness reminder, recoil, healing, reduction, immunity, and triggered-effect information.
- A connection failure never disables offline play. Disconnecting returns the application to its original manual tabletop flow.

## Responsive layout

- Around 1280×720: two columns on the selection screen and a 2×2 move-card layout during play.
- At 1600 px and above: three columns on the selection screen.
- At 1500 px and above, with sufficient height: all four play cards appear in one row.
- At 2400 px and above: four columns on the selection screen to make use of 21:9 displays.
- Narrower viewports fall back to one or two columns. Pages and lists remain vertically scrollable so controls are not clipped.
- Crossing a layout breakpoint triggers automatic reflow without clearing the selected moves.

## Data and localization

```text
database/pokemon/        Pokémon data
database/move_cards/     Move-card and Charakoro outcome data
language/content/        Pokémon, move, and card-effect translations
assets/pokemon/images/   Pokémon images
assets/move_cards/       Move-card background
assets/ui/energy/        Type and Enekoro icons
assets/ui/kyokoro/       Charakoro face icons
assets/fonts/            Noto Sans fonts and licenses
```

Localization lookup prioritizes card-specific `move_card.<card_id>` entries and then falls back to shared `move.<move_name_id>` entries. This supports moves that share a name but have different card effects.

## Running and exporting

1. Open `project.godot` in Godot 4.7 or a compatible Godot 4.x release.
2. Run the main scene at `scenes/Main.tscn`.
3. Install export templates matching the Godot version in use.
4. Export with the included presets:

```text
Windows → build/windows/Plakoro_Digital_Move_Cards.exe
Linux   → build/linux/Plakoro_Digital_Move_Cards.x86_64
Web     → web/index.html
```

The generated `build/` and `web/` directories and the local Godot cache at `.godot/` are excluded from Git.

## Project scope

This is a tabletop companion, not a second automated battle engine. Damage, healing, Weakness, defense, and special rules that depend on the physical tabletop state should be resolved by the players. The digital application's role is to make move cards easier to read, reduce the Japanese-language barrier, and help players remember effects that continue across turns.
