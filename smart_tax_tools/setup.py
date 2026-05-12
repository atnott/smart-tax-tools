from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name='smart-tax-tools',
    version='0.0.3',
    author='Anton',
    description="Библиотека для автоматизации финансовых расчетов и налогов",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/atnott/smart-tax-tools",
    package_dir={'': 'src'},
    packages=find_packages(where='src'),
    python_requires='>=3.10'
)
