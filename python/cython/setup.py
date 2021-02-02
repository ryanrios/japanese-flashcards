from setuptools import setup
from Cython.Build import cythonize

setup(
    name="Parse app",
    ext_modules=cythonize("parse.pyx"),
    zip_safe=False
)