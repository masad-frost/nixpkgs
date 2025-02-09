{ lib
, fetchPypi
, pythonOlder
, buildPythonPackage
, pip
, pytestCheckHook
, pytest-xdist
, click
, setuptools-scm
, pep517
}:

buildPythonPackage rec {
  pname = "pip-tools";
  version = "6.6.0";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-mKokAERAocBInXGlZ6Tor98jx3gr/0g9EhmIHnMC3oM=";
  };

  checkInputs = [
    pytestCheckHook
    pytest-xdist
  ];

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    click
    pep517
    pip
  ];

  disabledTests = [
    # these want internet access
    "network"
    "test_direct_reference_with_extras"
  ];

  meta = with lib; {
    description = "Keeps your pinned dependencies fresh";
    homepage = "https://github.com/jazzband/pip-tools/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ zimbatm ];
  };
}
