# Andes AX45MPV donor VPU verilog library
load("@rules_hdl//verilog:providers.bzl", "verilog_library")

verilog_library(
    name = "kv_vpu_all",
    srcs = glob([
        "vpu/hdl/*.v",
        "ucore/hdl/*.v",
        "macro/hdl/*.v",
        "ace/hdl/*.v",
        "biu/hdl/*.v",
        "tilelink/hdl/*.v",
        "fpu/hdl/*.v",
        "top/hdl/*.inc",
    ]),
    visibility = ["//visibility:public"],
)
