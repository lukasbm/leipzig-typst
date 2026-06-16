import platform
import os
import tomllib
from shutil import copyfile, copytree, ignore_patterns, copy, rmtree

# source: https://github.com/typst/packages#local-packages


def determine_data_dir() -> str:
    if platform.system().lower() == "linux":
        return os.path.join(os.environ["HOME"], ".local", "share")
    elif platform.system().lower() == "windows":
        return os.path.join(os.environ["APPDATA"])
    elif platform.system().lower() == "darwin":
        return os.path.join(os.environ["HOME"], "Library", "Application Support")
    else:
        raise NotImplementedError("Unknown platform")


def copy_files(source_dir: str, target_dir: str) -> None:
    rmtree(target_dir, ignore_errors=True)

    ign = ignore_patterns("*.pyc", "__pycache__", "*.pdf")
    # assets
    os.makedirs(os.path.join(target_dir, "assets"))
    copytree(
        os.path.join(source_dir, "assets"),
        os.path.join(target_dir, "assets"),
        ignore=ign,
        dirs_exist_ok=True,
    )
    # lib
    os.makedirs(os.path.join(target_dir, "lib"))
    copytree(
        os.path.join(source_dir, "lib"),
        os.path.join(target_dir, "lib"),
        ignore=ign,
        dirs_exist_ok=True,
    )
    # entrypoint
    copy(
        os.path.join(source_dir, "leipzig-typst.typ"),
        target_dir,
    )
    # manifest
    copy(os.path.join(source_dir, "typst.toml"), target_dir)


if __name__ == "__main__":
    name = ""
    version = ""
    with open("typst.toml", "rb") as f:
        toml = tomllib.load(f)
        name = toml["package"]["name"]
        version = toml["package"]["version"]

    # copy files
    target_dir = os.path.join(determine_data_dir(), "typst", "packages", "local", name, version)
    print("Copying files to", target_dir)
    copy_files(
        source_dir=os.getcwd(),
        target_dir=target_dir
    )
    print("Done.")
