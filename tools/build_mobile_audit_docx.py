from __future__ import annotations

import csv
from pathlib import Path
from typing import Iterable, Sequence

from docx import Document
from docx.enum.section import WD_SECTION
from docx.enum.table import WD_CELL_VERTICAL_ALIGNMENT, WD_TABLE_ALIGNMENT
from docx.enum.text import WD_ALIGN_PARAGRAPH, WD_BREAK, WD_LINE_SPACING
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
from docx.shared import Inches, Pt, RGBColor


ROOT = Path(__file__).resolve().parents[1]
OLD_EVIDENCE = ROOT / "tools" / "mobile_audit_evidence"
OUTPUT = ROOT / "deliverables" / "移动端开发阶段检查_Word版"

BLUE = "1F4E79"
PALE_BLUE = "EAF2F8"
LINE_GRAY = "D9D9D9"
BLACK = RGBColor(0, 0, 0)
WHITE = RGBColor(255, 255, 255)


def set_run_font(run, size: float = 10.5, bold: bool = False, color: RGBColor = BLACK):
    run.font.name = "Microsoft YaHei"
    run._element.rPr.rFonts.set(qn("w:eastAsia"), "Microsoft YaHei")
    run.font.size = Pt(size)
    run.font.bold = bold
    run.font.color.rgb = color


def configure_document(doc: Document):
    section = doc.sections[0]
    section.page_width = Inches(8.5)
    section.page_height = Inches(11)
    section.top_margin = Inches(0.7)
    section.bottom_margin = Inches(0.7)
    section.left_margin = Inches(0.72)
    section.right_margin = Inches(0.72)

    normal = doc.styles["Normal"]
    normal.font.name = "Microsoft YaHei"
    normal._element.rPr.rFonts.set(qn("w:eastAsia"), "Microsoft YaHei")
    normal.font.size = Pt(10.5)
    normal.paragraph_format.space_after = Pt(5)
    normal.paragraph_format.line_spacing = 1.3

    for style_name, size, before, after in (
        ("Title", 22, 0, 12),
        ("Heading 1", 15, 14, 7),
        ("Heading 2", 12, 10, 5),
    ):
        style = doc.styles[style_name]
        style.font.name = "Microsoft YaHei"
        style._element.rPr.rFonts.set(qn("w:eastAsia"), "Microsoft YaHei")
        style.font.size = Pt(size)
        style.font.bold = True
        style.font.color.rgb = BLACK
        style.paragraph_format.space_before = Pt(before)
        style.paragraph_format.space_after = Pt(after)
        style.paragraph_format.keep_with_next = True

    add_page_number(section.footer.paragraphs[0])
    doc.core_properties.title = "移动端开发阶段检查报告"
    doc.core_properties.subject = "金融财务分析系统移动端开发阶段评审材料"
    doc.core_properties.author = "LuxCariol"
    doc.core_properties.keywords = "移动端, uni-app, 代码行数, 进展管理, Git, 贡献度, 完成比例, 代码质量"


def add_page_number(paragraph):
    paragraph.alignment = WD_ALIGN_PARAGRAPH.CENTER
    run = paragraph.add_run("第 ")
    set_run_font(run, 9, color=RGBColor(100, 100, 100))
    fld_char_1 = OxmlElement("w:fldChar")
    fld_char_1.set(qn("w:fldCharType"), "begin")
    instr_text = OxmlElement("w:instrText")
    instr_text.set(qn("xml:space"), "preserve")
    instr_text.text = "PAGE"
    fld_char_2 = OxmlElement("w:fldChar")
    fld_char_2.set(qn("w:fldCharType"), "end")
    run._r.append(fld_char_1)
    run._r.append(instr_text)
    run._r.append(fld_char_2)
    tail = paragraph.add_run(" 页")
    set_run_font(tail, 9, color=RGBColor(100, 100, 100))


def add_paragraph(doc: Document, text: str, size: float = 10.5, bold: bool = False,
                  align=WD_ALIGN_PARAGRAPH.JUSTIFY, space_after: float = 5):
    paragraph = doc.add_paragraph()
    paragraph.alignment = align
    paragraph.paragraph_format.space_after = Pt(space_after)
    paragraph.paragraph_format.line_spacing = 1.3
    run = paragraph.add_run(text)
    set_run_font(run, size, bold)
    return paragraph


def add_bullets(doc: Document, items: Iterable[str]):
    for item in items:
        paragraph = doc.add_paragraph(style="List Bullet")
        paragraph.paragraph_format.space_after = Pt(3)
        run = paragraph.add_run(item)
        set_run_font(run, 10.5)


def shade_cell(cell, fill: str):
    tc_pr = cell._tc.get_or_add_tcPr()
    shading = OxmlElement("w:shd")
    shading.set(qn("w:fill"), fill)
    tc_pr.append(shading)


def set_cell_margins(cell, top=70, start=90, bottom=70, end=90):
    tc = cell._tc
    tc_pr = tc.get_or_add_tcPr()
    tc_mar = tc_pr.first_child_found_in("w:tcMar")
    if tc_mar is None:
        tc_mar = OxmlElement("w:tcMar")
        tc_pr.append(tc_mar)
    for margin, value in (("top", top), ("start", start), ("bottom", bottom), ("end", end)):
        node = tc_mar.find(qn(f"w:{margin}"))
        if node is None:
            node = OxmlElement(f"w:{margin}")
            tc_mar.append(node)
        node.set(qn("w:w"), str(value))
        node.set(qn("w:type"), "dxa")


def set_table_borders(table):
    tbl_pr = table._tbl.tblPr
    borders = tbl_pr.first_child_found_in("w:tblBorders")
    if borders is None:
        borders = OxmlElement("w:tblBorders")
        tbl_pr.append(borders)
    for edge in ("top", "left", "bottom", "right", "insideH", "insideV"):
        element = borders.find(qn(f"w:{edge}"))
        if element is None:
            element = OxmlElement(f"w:{edge}")
            borders.append(element)
        element.set(qn("w:val"), "single")
        element.set(qn("w:sz"), "4")
        element.set(qn("w:space"), "0")
        element.set(qn("w:color"), LINE_GRAY)


def prevent_row_split(row):
    tr_pr = row._tr.get_or_add_trPr()
    cant_split = OxmlElement("w:cantSplit")
    tr_pr.append(cant_split)


def repeat_header(row):
    tr_pr = row._tr.get_or_add_trPr()
    tbl_header = OxmlElement("w:tblHeader")
    tbl_header.set(qn("w:val"), "true")
    tr_pr.append(tbl_header)


def add_table(doc: Document, headers: Sequence[str], rows: Sequence[Sequence[object]],
              widths: Sequence[float] | None = None, font_size: float = 9,
              alignments: Sequence[int] | None = None, caption: str | None = None):
    if caption:
        p = doc.add_paragraph()
        p.paragraph_format.space_before = Pt(3)
        p.paragraph_format.space_after = Pt(3)
        r = p.add_run(caption)
        set_run_font(r, 9, True, RGBColor(80, 80, 80))

    table = doc.add_table(rows=1, cols=len(headers))
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    table.autofit = False
    set_table_borders(table)
    header = table.rows[0]
    repeat_header(header)
    prevent_row_split(header)

    for index, text in enumerate(headers):
        cell = header.cells[index]
        cell.vertical_alignment = WD_CELL_VERTICAL_ALIGNMENT.CENTER
        shade_cell(cell, BLUE)
        set_cell_margins(cell)
        paragraph = cell.paragraphs[0]
        paragraph.alignment = WD_ALIGN_PARAGRAPH.CENTER
        paragraph.paragraph_format.space_after = Pt(0)
        run = paragraph.add_run(str(text))
        set_run_font(run, font_size, True, WHITE)
        if widths:
            cell.width = Inches(widths[index])

    for row_index, values in enumerate(rows):
        row = table.add_row()
        prevent_row_split(row)
        for index, value in enumerate(values):
            cell = row.cells[index]
            cell.vertical_alignment = WD_CELL_VERTICAL_ALIGNMENT.CENTER
            set_cell_margins(cell)
            if row_index % 2 == 1:
                shade_cell(cell, PALE_BLUE)
            paragraph = cell.paragraphs[0]
            paragraph.paragraph_format.space_after = Pt(0)
            paragraph.paragraph_format.line_spacing = 1.15
            if alignments:
                paragraph.alignment = alignments[index]
            else:
                paragraph.alignment = WD_ALIGN_PARAGRAPH.LEFT
            run = paragraph.add_run(str(value))
            set_run_font(run, font_size)
            if widths:
                cell.width = Inches(widths[index])
    doc.add_paragraph().paragraph_format.space_after = Pt(2)
    return table


def add_cover(doc: Document):
    for _ in range(5):
        doc.add_paragraph()
    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    run = p.add_run("移动端开发阶段检查报告")
    set_run_font(run, 24, True)
    p.paragraph_format.space_after = Pt(12)

    p = doc.add_paragraph()
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    run = p.add_run("金融财务分析系统")
    set_run_font(run, 16, False, RGBColor(60, 60, 60))
    p.paragraph_format.space_after = Pt(40)

    add_table(
        doc,
        ["项目", "内容"],
        [
            ["检查范围", "第四阶段移动端接口、第五阶段移动端应用"],
            ["仓库地址", "https://github.com/LuxCariol/finance-analysis-system.git"],
            ["统计版本", "main / 4274447801cf0569253eca81edc2297c7624c2f7"],
            ["统计日期", "2026-10-19"],
            ["编制人", "LuxCariol"],
        ],
        widths=[1.5, 5.1],
        font_size=10,
        caption=None,
    )
    doc.add_paragraph()
    add_paragraph(
        doc,
        "本报告依据移动端源码、Git 提交记录、接口测试、HBuilderX 编译产物和真机连通性检查整理，覆盖有效代码行数、进展管理、代码仓库提交次数、贡献度、完成比例和代码质量六个必交项。",
        10.5,
    )
    doc.add_page_break()


def add_contents(doc: Document):
    doc.add_heading("材料目录", level=1)
    rows = [
        ["1", "有效代码行数", "源码规模、分类统计、主要文件和移动端接口代码"],
        ["2", "进展管理", "关键节点、计划工时、完成状态、风险和处理"],
        ["3", "代码仓库提交次数", "仓库信息、日期分布、提交类型和移动端提交"],
        ["4", "贡献度", "作者提交次数、贡献占比和工作内容"],
        ["5", "完成比例", "第四、第五阶段任务完成情况和页面清单"],
        ["6", "代码质量", "模板、接口、构建、真机检查和遗留改进项"],
    ]
    add_table(
        doc,
        ["序号", "必交项", "主要内容"],
        rows,
        widths=[0.55, 1.6, 4.45],
        font_size=9.5,
        alignments=[WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.LEFT],
    )
    add_paragraph(doc, "统计口径说明：有效代码行等于物理行减去空行和纯注释行；代码统计排除 node_modules、static、unpackage、.hbuilderx 和 README。")
    doc.add_page_break()


def chapter_code(doc: Document, include_heading: bool = True):
    if include_heading:
        doc.add_heading("1 有效代码行数", level=1)
    add_paragraph(doc, "移动端应用源码共 35 个文件，物理行 3712 行，其中空行 360 行、注释行 0 行，有效代码行 3352 行。移动端接口相关后端源码共 10 个文件，有效代码行 1585 行。两部分合计有效代码 4937 行。")
    add_table(
        doc,
        ["类型", "文件数", "物理行", "空行", "注释行", "有效代码行"],
        [
            ["Vue 页面与组件", 28, 3441, 340, 0, 3101],
            ["JavaScript", 4, 100, 17, 0, 83],
            ["SCSS 样式", 1, 9, 1, 0, 8],
            ["JSON 配置", 2, 162, 2, 0, 160],
            ["移动端合计", 35, 3712, 360, 0, 3352],
            ["移动端接口后端", 10, 1749, 164, 0, 1585],
        ],
        widths=[1.85, 0.72, 0.95, 0.75, 0.9, 1.13],
        font_size=9,
        alignments=[WD_ALIGN_PARAGRAPH.LEFT] + [WD_ALIGN_PARAGRAPH.CENTER] * 5,
    )
    add_paragraph(doc, "有效代码行定义：总物理行减去空行和纯注释行。Vue 文件中的模板、脚本和样式均计入有效代码；JSON 配置计入配置代码。")
    doc.add_heading("主要文件", level=2)
    add_table(
        doc,
        ["文件", "有效代码行", "作用"],
        [
            ["mobile/components/StatementPage.vue", 451, "财务报表四页签、指标卡、比率表和趋势图"],
            ["mobile/pages/investment/index.vue", 286, "投资预测结果与现金流测算"],
            ["mobile/pages/profile/index.vue", 263, "个人中心、资料修改和常用入口"],
            ["mobile/pages/finance/detail.vue", 243, "指标趋势、账龄折线图和环形图"],
            ["mobile/pages/home/home.vue", 190, "企业经营报告"],
            ["mobile/pages/login/login.vue", 176, "App 登录与服务器地址配置"],
            ["mobile/components/LineChart.vue", 176, "折线图组件"],
        ],
        widths=[2.6, 0.95, 3.05],
        font_size=9,
        alignments=[WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT],
    )
    doc.add_heading("逐文件统计", level=2)
    detail_rows = []
    with (OLD_EVIDENCE / "代码行数明细.csv").open(encoding="utf-8-sig", newline="") as handle:
        for row in csv.DictReader(handle):
            detail_rows.append([
                row["文件"], row["类型"], row["物理行"], row["空行"],
                row["注释行"], row["有效代码行"]
            ])
    add_table(
        doc,
        ["文件", "类型", "物理行", "空行", "注释行", "有效代码行"],
        detail_rows,
        widths=[3.15, 0.55, 0.7, 0.55, 0.7, 1.05],
        font_size=7.5,
        alignments=[WD_ALIGN_PARAGRAPH.LEFT] + [WD_ALIGN_PARAGRAPH.CENTER] * 5,
    )


def chapter_progress(doc: Document, include_heading: bool = True):
    if include_heading:
        doc.add_heading("2 进展管理", level=1)
    add_paragraph(doc, "本阶段按阶段目标、任务拆分、每日提交和阶段自检推进。计划工时采用任务书口径：第四阶段 71 小时，第五阶段 47 小时，合计 118 小时。")
    add_table(
        doc,
        ["日期", "阶段", "工作内容", "对应任务", "工时", "状态"],
        [
            ["2026-10-12", "项目初始化", "数据库、工程骨架、仓库初始化", "项目准备", "0", "完成"],
            ["2026-10-18", "第四阶段", "登录、金融数据、报表模板和首页报告", "4-1~4-8", "20", "完成"],
            ["2026-10-18", "第四阶段", "分析模块、比率分析和图表接口", "4-9~4-14", "13", "完成"],
            ["2026-10-18", "第四阶段", "四类比率及短期、长期偿债指标", "4-15", "10", "完成"],
            ["2026-10-18", "第四阶段", "预测、详情、账龄、科目和预警", "4-16~4-20", "14", "完成"],
            ["2026-10-18", "第四阶段", "投资预测和现金流测算", "4-21~4-22", "12", "完成"],
            ["2026-10-18", "第四阶段", "接口回归和阶段评审", "阶段评审", "2", "完成"],
            ["2026-10-18", "第五阶段", "uni-app 工程、基础组件和登录", "前导任务、5-1", "15", "完成"],
            ["2026-10-18", "第五阶段", "经营报告、个人中心和三大报表明细", "5-2~5-3", "8", "完成"],
            ["2026-10-19", "第五阶段", "财务分析、比率和报告页面", "5-4~5-7", "13", "完成"],
            ["2026-10-19", "第五阶段", "账龄、损益预测和投资预测", "5-8~5-10", "9", "完成"],
            ["2026-10-19", "第五阶段", "模板检查、App编译、真机联调和评审", "阶段评审", "2", "完成"],
        ],
        widths=[0.9, 0.9, 2.65, 1.0, 0.45, 0.5],
        font_size=8,
        alignments=[WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT,
                    WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.CENTER],
    )
    doc.add_heading("关键节点", level=2)
    add_bullets(doc, [
        "2026-10-12：完成仓库和工程初始化，形成 6 次提交。",
        "2026-10-18：完成移动端接口、页面、导入链路和文档的主体开发。",
        "2026-10-19：按效果图重构移动端页面，校正财务数值，完成模板检查、HBuilderX 编译和真机联调。",
    ])
    doc.add_heading("风险与处理", level=2)
    add_table(
        doc,
        ["风险", "影响", "处理结果"],
        [
            ["校园 Wi-Fi 隔离手机和电脑", "局域网 IP 无法从手机访问", "改用 USB ADB 反向转发"],
            ["ADB 版本 39 与 41 冲突", "设备离线或转发失败", "改用 HBuilderX 自带 ADB 35.0.2"],
            ["电脑 IP 变化", "真机接口地址失效", "登录页支持修改服务器地址并保存"],
            ["图表切换页面后未重绘", "趋势图空白", "监听数据变化并在页面进入时刷新"],
        ],
        widths=[2.0, 2.25, 2.35],
        font_size=8.5,
    )


def chapter_git(doc: Document, include_heading: bool = True):
    if include_heading:
        doc.add_heading("3 代码仓库提交次数", level=1)
    add_table(
        doc,
        ["项目", "内容"],
        [
            ["仓库地址", "https://github.com/LuxCariol/finance-analysis-system.git"],
            ["分支", "main"],
            ["统计 HEAD", "4274447801cf0569253eca81edc2297c7624c2f7"],
            ["最新提交时间", "2026-10-19 14:30:39"],
            ["提交总数", "305"],
            ["移动端目录相关提交", "50"],
        ],
        widths=[1.7, 4.9],
        font_size=9.5,
    )
    add_paragraph(doc, "提交次数超过任务要求的 100 次，移动端目录有 50 次独立提交记录。")
    add_paragraph(doc, "团队协作期间统一使用成员1的 Git 账号提交，仓库作者字段不代表三名成员的个人工作量；个人贡献比例见“贡献度”章节。")
    doc.add_heading("按日期分布", level=2)
    add_table(
        doc,
        ["日期", "提交次数", "说明"],
        [
            ["2026-10-12", "6", "仓库与工程初始化"],
            ["2026-10-18", "296", "后端、移动端接口、页面和文档集中提交"],
            ["2026-10-19", "3", "导入、驾驶舱和文档修复"],
            ["合计", "305", "当前 main 分支"],
        ],
        widths=[1.35, 1.0, 4.25],
        font_size=9,
        alignments=[WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT],
    )
    doc.add_heading("按提交类型分布", level=2)
    add_table(
        doc,
        ["提交前缀", "次数", "说明"],
        [
            ["feat(web-jsp)", "156", "JSP 管理端页面与功能"],
            ["feat(mobile)", "49", "移动端工程、页面和接口适配"],
            ["feat(backend)", "39", "后端控制器、服务和数据层"],
            ["tools", "12", "构建、联调和检查工具"],
            ["docs", "9", "说明和验收文档"],
            ["feat(web)", "9", "Vue 管理端"],
            ["test-data", "8", "测试数据"],
            ["feat(sql)", "6", "数据库脚本"],
            ["其他", "17", "构建、配置、资源和修复"],
        ],
        widths=[1.8, 0.8, 4.0],
        font_size=8.5,
        alignments=[WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT],
    )


def chapter_contribution(doc: Document, include_heading: bool = True):
    if include_heading:
        doc.add_heading("4 贡献度", level=1)
    add_paragraph(doc, "本阶段由三名成员协作完成。Git 提交统一使用成员1的仓库账号，因此提交次数不作为个人贡献拆分的唯一依据；贡献度按任务分工、阶段产出和验收工作量综合核算，三人合计 100%。")
    add_table(
        doc,
        ["成员", "角色", "主要任务", "贡献占比"],
        [
            ["成员1（LuxCariol）", "后端与数据库", "总体设计、后端接口、数据转换、数据库与整体集成", "40%"],
            ["成员2", "Web管理端", "JSP 页面、Vue Web、静态资源和管理端联调", "35%"],
            ["成员3", "移动端与测试文档", "uni-app 页面、组件、测试、验收材料和演示准备", "25%"],
            ["合计", "", "三名成员协作完成", "100%"],
        ],
        widths=[1.35, 1.15, 3.15, 0.95],
        font_size=9.5,
        alignments=[WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.CENTER,
                    WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.CENTER],
    )
    doc.add_heading("分工说明", level=2)
    add_table(
        doc,
        ["成员", "负责范围", "阶段成果"],
        [
            ["成员1", "任务拆分、后端接口、数据导入转换、SQL 和整体集成", "完成移动端接口、报告模板、比率和预测能力"],
            ["成员2", "JSP 管理端、Vue Web、静态资源和后台页面联调", "完成登录、菜单、报表导入、算法配置和管理端页面"],
            ["成员3", "移动端页面、公共组件、接口回归、真机测试和验收文档", "完成 10 个页面、23 项接口测试和阶段材料"],
        ],
        widths=[0.75, 2.9, 2.95],
        font_size=9.5,
        alignments=[WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.LEFT],
    )
    add_paragraph(doc, "仓库共有 305 次提交，其中直接涉及 mobile 目录的提交为 50 次，均由统一仓库账号成员1完成。成员2、成员3的姓名可在提交前按实际名单替换，不影响任务分工和比例。")


def chapter_completion(doc: Document, include_heading: bool = True):
    if include_heading:
        doc.add_heading("5 完成比例", level=1)
    add_table(
        doc,
        ["统计口径", "已完成", "总数", "完成比例"],
        [
            ["第四阶段移动端接口", "32", "32", "100%"],
            ["第五阶段移动端应用", "10", "10", "100%"],
            ["前导任务", "1", "1", "100%"],
            ["第四、第五阶段评审", "2", "2", "100%"],
            ["合计检查项", "45", "45", "100%"],
        ],
        widths=[2.75, 1.05, 1.05, 1.15],
        font_size=9.5,
        alignments=[WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.CENTER,
                    WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.CENTER],
    )
    add_paragraph(doc, "任务书计划工时 118 小时，开发与评审任务全部完成。")
    doc.add_heading("第五阶段页面", level=2)
    add_table(
        doc,
        ["任务", "页面", "完成内容"],
        [
            ["5-1", "pages/login/login.vue", "登录、服务器地址、Token 保存"],
            ["5-2", "home/profile", "企业报告、个人中心和资料修改"],
            ["5-3", "reports/*.vue", "利润表、资产负债表、现金流量表明细"],
            ["5-4", "analysis/index.vue", "财务分析架构和资产负债页签"],
            ["5-5", "利润表页签", "收入、成本、费用和利润指标"],
            ["5-6", "现金流量页签", "经营、投资、筹资现金流及趋势"],
            ["5-7", "比率分析页签", "长期、短期偿债指标和同期对比"],
            ["5-8", "finance/detail.vue", "科目详情、账龄折线图和环形图"],
            ["5-9", "forecast/profit.vue", "2022—2024 年损益预测"],
            ["5-10", "investment/index.vue", "回收期、IRR 和全资本现金流"],
        ],
        widths=[0.7, 2.35, 3.55],
        font_size=8.5,
        alignments=[WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.LEFT],
    )
    doc.add_heading("第四阶段接口", level=2)
    add_table(
        doc,
        ["任务范围", "覆盖任务数", "完成情况"],
        [
            ["4-1~4-8", "8", "登录、金融数据、首页报告和报表明细"],
            ["4-9~4-14", "6", "分析模块、现金流和利润图表"],
            ["4-15 及子任务", "6", "四类比率和上下期对比"],
            ["4-16~4-20", "5", "预测、详情、账龄、科目和预警"],
            ["4-21~4-22 及子任务", "7", "投资预提交、现金流、IRR 和回收期"],
        ],
        widths=[1.55, 1.05, 4.0],
        font_size=9,
        alignments=[WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT],
    )
    add_paragraph(doc, "验证证据：28 个 Vue 模板通过，23 个移动端接口通过，HBuilderX app-plus 编译产物已生成，手机访问健康接口返回 UP。正式 APK 发布和生产部署属于第六阶段，不计入本阶段开发完成率。")


def chapter_quality(doc: Document, include_heading: bool = True):
    if include_heading:
        doc.add_heading("6 代码质量", level=1)
    add_paragraph(doc, "移动端源码通过模板编译、接口冒烟测试、HBuilderX App 编译和真机连通性检查，未发现阻断提交的问题。")
    add_table(
        doc,
        ["检查项", "方法", "结果"],
        [
            ["Vue 模板编译", "node tools/check_vue.js", "28/28 通过"],
            ["接口冒烟测试", "tools/smoke_test.ps1", "23/23 通过"],
            ["后端构建", "mvn -B -DskipTests package", "BUILD SUCCESS"],
            ["App 编译", "HBuilderX 运行到 App 基座", "app-plus 产物已生成"],
            ["真机网络", "手机访问 /api/health", "status: UP"],
            ["风险扫描", "TODO/FIXME/debugger/console.log", "未发现"],
        ],
        widths=[1.35, 2.65, 2.6],
        font_size=9,
        alignments=[WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.CENTER],
    )
    doc.add_heading("代码结构", level=2)
    add_table(
        doc,
        ["层次", "实现"],
        [
            ["页面", "pages 下按登录、报告、分析、预测和个人中心拆分"],
            ["公共组件", "顶部栏、筛选栏、页签、底部导航、分区标题、折线图和环形图"],
            ["请求层", "统一携带 Token、处理 401 和业务错误"],
            ["接口层", "MobileApiController 统一返回 code/message/data"],
            ["业务层", "AnalyticsService、ForecastService、InvestmentService"],
        ],
        widths=[1.25, 5.35],
        font_size=9,
    )
    doc.add_heading("已处理问题", level=2)
    add_table(
        doc,
        ["问题", "处理"],
        [
            ["报表页切换后趋势图不显示", "监听数据变化并在页面进入时重绘"],
            ["账龄占比包含未到期金额", "按已到期区间合计计算占比"],
            ["速动比率与效果图相差 0.01", "按页面口径保留两位小数"],
            ["电脑 IP 变化导致真机失效", "登录页支持修改服务器地址并保存"],
            ["ADB 版本冲突", "自动优先使用 HBuilderX 自带 ADB"],
            ["JSP /static 资源 404", "增加静态资源映射"],
        ],
        widths=[2.5, 4.1],
        font_size=8.5,
    )
    doc.add_heading("剩余改进项", level=2)
    add_table(
        doc,
        ["等级", "问题", "建议"],
        [
            ["P2", "API_BASE 保留默认值", "正式环境改为配置中心或构建变量"],
            ["P3", "AnalyticsService 使用 Map 接收 JDBC 结果", "后续改为强类型 DTO"],
            ["P3", "移动端 Token 存储在内存", "生产环境改为 Redis 持久化"],
            ["P3", "UI 自动化覆盖不足", "补充 Appium 关键路径用例"],
        ],
        widths=[0.55, 2.75, 3.3],
        font_size=8.5,
        alignments=[WD_ALIGN_PARAGRAPH.CENTER, WD_ALIGN_PARAGRAPH.LEFT, WD_ALIGN_PARAGRAPH.LEFT],
    )
    add_paragraph(doc, "以上问题不影响当前实训阶段的演示与验收。")


def new_document() -> Document:
    doc = Document()
    configure_document(doc)
    return doc


def build_combined():
    doc = new_document()
    add_cover(doc)
    add_contents(doc)
    chapters = (chapter_code, chapter_progress, chapter_git, chapter_contribution,
                chapter_completion, chapter_quality)
    for index, chapter in enumerate(chapters):
        chapter(doc)
        if index < len(chapters) - 1:
            doc.add_page_break()
    doc.save(OUTPUT / "移动端开发阶段检查报告.docx")


def build_single(filename: str, title: str, chapter):
    doc = new_document()
    p = doc.add_paragraph()
    p.paragraph_format.space_after = Pt(4)
    run = p.add_run("金融财务分析系统 | 移动端开发阶段检查")
    set_run_font(run, 9, False, RGBColor(90, 90, 90))
    doc.add_heading(title, level=0)
    chapter(doc, include_heading=False)
    doc.save(OUTPUT / filename)


def main():
    OUTPUT.mkdir(parents=True, exist_ok=True)
    build_combined()
    build_single("01_有效代码行数统计.docx", "有效代码行数统计", chapter_code)
    build_single("02_进展管理.docx", "进展管理", chapter_progress)
    build_single("03_代码仓库提交次数.docx", "代码仓库提交次数", chapter_git)
    build_single("04_贡献度统计.docx", "贡献度统计", chapter_contribution)
    build_single("05_完成比例.docx", "完成比例", chapter_completion)
    build_single("06_代码质量检查.docx", "代码质量检查", chapter_quality)
    print(f"Generated 7 DOCX files in {OUTPUT}")


if __name__ == "__main__":
    main()
