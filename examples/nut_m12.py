from cadgen import build123d as bd
from cadgen import step, stl

# M12 六角螺母 (ISO 4032 / DIN 934)
S = 19.0          # 对边宽度 (mm)
H = 10.0          # 螺母高度 (mm)
HOLE_D = 10.106   # M12x1.75 内螺纹小径 = 丝锥底孔
CHAMFER = 1.2     # 上下端面倒角

R = S / (3 ** 0.5)  # 六角外接圆半径


@step(out="../STEP/nut_m12.step")
@stl(out="../STL/nut_m12.stl")
def nut_m12():
    body = bd.extrude(bd.RegularPolygon(R, 6), amount=H / 2, both=True)
    # 螺纹底孔
    body = body - bd.Cylinder(HOLE_D / 2, H + 2)
    # 上下端面外缘倒角
    body = bd.chamfer(
        body.edges().filter_by_position(bd.Axis.Z, H / 2 - 0.01, H / 2 + 0.01),
        CHAMFER,
    )
    body = bd.chamfer(
        body.edges().filter_by_position(bd.Axis.Z, -H / 2 - 0.01, -H / 2 + 0.01),
        CHAMFER,
    )
    body.label = "M12_nut"
    return body


if __name__ == "__main__":
    nut_m12()
