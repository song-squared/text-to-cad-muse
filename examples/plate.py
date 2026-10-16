from cadgen import build123d as bd
from cadgen import step, stl

L, W, T = 100.0, 60.0, 8.0      # 板长/宽/厚 (mm)
HOLE_D = 6.0                     # 四角通孔直径
EDGE = 10.0                      # 孔心到边缘距离
CENTER_HOLE_D = 20.0             # 中心通孔直径


@step(out="../STEP/plate.step")
@stl(out="../STL/plate.stl")
def plate():
    body = bd.Box(L, W, T)
    # 四角通孔
    for sx in (-1, 1):
        for sy in (-1, 1):
            x = sx * (L / 2 - EDGE)
            y = sy * (W / 2 - EDGE)
            hole = bd.Cylinder(HOLE_D / 2, T + 2)
            hole = hole.moved(bd.Location((x, y, 0)))
            body = body - hole
    # 中心通孔
    body = body - bd.Cylinder(CENTER_HOLE_D / 2, T + 2)
    body.label = "plate"
    return body


if __name__ == "__main__":
    plate()
